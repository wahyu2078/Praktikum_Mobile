import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Mobile-only imports
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Web-only imports
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui;

late List<CameraDescription> _availableCameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    _availableCameras = await availableCameras();
  } else {
    // register html video element (compatible dengan banyak versi Flutter web)
    final registry = _getViewRegistry();
    registry.registerViewFactory('web-camera-video', (int viewId) {
      final video = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover';
      return video;
    });
  }

  runApp(const MyApp());
}

dynamic _getViewRegistry() {
  try {
    // ignore: undefined_prefixed_name
    return ui.webViewRegistry;
  } catch (_) {
    // ignore: undefined_prefixed_name
    return ui.platformViewRegistry;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Praktikum',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const CameraHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CameraHome extends StatefulWidget {
  const CameraHome({super.key});
  @override
  State<CameraHome> createState() => _CameraHomeState();
}

class _CameraHomeState extends State<CameraHome> {
  // Mobile
  CameraController? _controller;
  int _cameraIndex = 0;

  // Shared
  String? _lastSavedPath;
  bool _isTaking = false;

  // Web
  html.VideoElement? _videoElement;
  String _webFacing = 'user'; // 'user' or 'environment'

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _initWebCamera();
    } else {
      _initMobileCamera();
    }
  }

  // MOBILE
  Future<void> _initMobileCamera() async {
    if (_availableCameras.isEmpty) return;
    _controller?.dispose();
    _controller = CameraController(
      _availableCameras[_cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      // ignore errors for now
    }
  }

  Future<void> _switchMobileCamera() async {
    if (_availableCameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _availableCameras.length;
    await _initMobileCamera();
  }

  Future<void> _takePictureMobile() async {
    if (_controller == null || !_controller!.value.isInitialized || _isTaking) return;
    setState(() => _isTaking = true);
    try {
      final XFile raw = await _controller!.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final ts = DateTime.now().toIso8601String().replaceAll(':', '-');
      final name = 'photo_$ts.jpg';
      final savedPath = p.join(appDir.path, name);
  final savedFile = await File(raw.path).copy(savedPath);
  if (!mounted) return;
  setState(() => _lastSavedPath = savedFile.path);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved: ${savedFile.path}')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error taking picture: $e')));
      }
    } finally {
      setState(() => _isTaking = false);
    }
  }

  // WEB
  Future<void> _initWebCamera() async {
    try {
      final stream = await html.window.navigator.mediaDevices?.getUserMedia({
        'video': {'facingMode': _webFacing}
      });
      _videoElement ??= html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover';
      _videoElement!.srcObject = stream;
      // register the actual element used by HtmlElementView
      // we created factory earlier, now replace the element in DOM by id trick:
      // simpler approach: put video element into a container with known id
      // but here we will just reuse the element from factory by setting src when requested.
      // to display, HtmlElementView('web-camera-video') will show the element created in factory;
      // so we also set the srcObject on the created element via querySelector if possible.
      // find the element created by factory and set srcObject if exists:
      final created = html.document.getElementsByTagName('flt-platform-view').where((e) {
        final el = e as html.Element;
        return el.getAttribute('view-type') == 'web-camera-video';
      }).toList();
      if (created.isNotEmpty) {
        final elem = created.first as html.Element;
        final videoElems = elem.querySelectorAll('video');
        if (videoElems.isNotEmpty) {
          (videoElems.first as html.VideoElement).srcObject = stream;
        }
      }
    } catch (e) {
      // ignore
    }
  }

  Future<void> _switchWebFacing() async {
    _webFacing = _webFacing == 'user' ? 'environment' : 'user';
    // stop current tracks
    try {
      final tracks = _videoElement?.srcObject is html.MediaStream
          ? (_videoElement!.srcObject as html.MediaStream).getTracks()
          : <html.MediaStreamTrack>[];
      for (final t in tracks) {
        t.stop();
      }
    } catch (_) {}
    await _initWebCamera();
  }

  Future<void> _takePictureWeb() async {
    if (_isTaking) return;
    setState(() => _isTaking = true);
    try {
      // find the video element used by HtmlElementView
      html.VideoElement? video;
      final flt = html.document.getElementsByTagName('flt-platform-view').where((e) {
        final el = e as html.Element;
        return el.getAttribute('view-type') == 'web-camera-video';
      }).toList();
      if (flt.isNotEmpty) {
  final vids = (flt.first as html.Element).querySelectorAll('video');
  if (vids.isNotEmpty) video = vids.first as html.VideoElement;
      }
      video ??= _videoElement;
      if (video == null) throw 'Video element not found';

      final w = video.videoWidth;
      final h = video.videoHeight;
      final canvas = html.CanvasElement(width: w, height: h);
      final ctx = canvas.context2D;
      ctx.drawImageScaled(video, 0, 0, w, h);
      final dataUrl = canvas.toDataUrl('image/jpeg', 0.92);
      // convert dataUrl to blob
  final parts = dataUrl.split(',');
  final base64Data = parts[1];
      final bytes = html.window.atob(base64Data);
      final buffer = Uint8List(bytes.length);
      for (var i = 0; i < bytes.length; i++) {
        buffer[i] = bytes.codeUnitAt(i);
      }
      final blob = html.Blob([buffer], 'image/jpeg');
      final objectUrl = html.Url.createObjectUrlFromBlob(blob);
  if (!mounted) return;
  setState(() => _lastSavedPath = objectUrl);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Captured (click to download)')));
      // create invisible link to trigger download if user wants
      final a = html.AnchorElement(href: objectUrl)
        ..download = 'photo_${DateTime.now().toIso8601String().replaceAll(':', '-')}.jpg'
        ..style.display = 'none';
      html.document.body?.append(a);
      a.click();
      a.remove();
      // Note: objectUrl can be revoked later if desired
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Web capture error: $e')));
      }
    } finally {
      setState(() => _isTaking = false);
    }
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _controller?.dispose();
    } else {
      try {
        final tracks = _videoElement?.srcObject is html.MediaStream
            ? (_videoElement!.srcObject as html.MediaStream).getTracks()
            : <html.MediaStreamTrack>[];
    for (final t in tracks) { t.stop(); }
      } catch (_) {}
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Praktikum')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: isWeb ? _buildWebPreview() : _buildMobilePreview(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: Text(_isTaking ? 'Processing...' : 'Ambil Foto'),
                    onPressed: _isTaking ? null : (isWeb ? _takePictureWeb : _takePictureMobile),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.cameraswitch),
                  onPressed: isWeb ? _switchWebFacing : ( _availableCameras.length < 2 ? null : _switchMobileCamera),
                  tooltip: 'Ganti Kamera',
                ),
              ],
            ),
          ),
          if (_lastSavedPath != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hasil terakhir:'),
                  const SizedBox(height: 6),
                  SelectableText(_lastSavedPath!),
                  const SizedBox(height: 8),
                  _lastSavedPath!.startsWith('blob:')
                      ? Image.network(_lastSavedPath!, height: 180)
                      : Image.file(File(_lastSavedPath!), height: 180),
                ],
              ),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildMobilePreview() {
    if (_controller == null) return const Center(child: Text('Initializing camera...'));
    if (!_controller!.value.isInitialized) return const Center(child: CircularProgressIndicator());
    return CameraPreview(_controller!);
  }

  Widget _buildWebPreview() {
    return HtmlElementView(viewType: 'web-camera-video');
  }
}
