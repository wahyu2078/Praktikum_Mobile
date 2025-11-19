import 'dart:html' as html;
import 'package:flutter/material.dart';
// abaikan warning ini, hanya aktif di web
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui;

void main() {
  // ✅ Universal registry: compatible semua versi Flutter
  final registry = _getViewRegistry();

  registry.registerViewFactory(
    'videoElement',
    (int viewId) {
      final video = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.border = 'none';

      html.window.navigator.mediaDevices
          ?.getUserMedia({'video': {'facingMode': 'user'}})
          .then((stream) => video.srcObject = stream)
          .catchError((e) => video.text = 'Camera error: $e');

      return video;
    },
  );

  runApp(const MyApp());
}

// Fungsi aman untuk dapatkan registry (webViewRegistry atau platformViewRegistry)
dynamic _getViewRegistry() {
  // Avoid referencing `ui.webViewRegistry` directly because that symbol
  // may not exist across Flutter versions and leads to a compile-time
  // undefined name error. Use the universal `platformViewRegistry` which
  // is the current canonical API for web view registration.
  // ignore: undefined_prefixed_name
  return ui.platformViewRegistry;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Camera',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const WebCameraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebCameraPage extends StatelessWidget {
  const WebCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Preview (Web)')),
      body: const Center(
        child: SizedBox(
          width: 480,
          height: 360,
          child: HtmlElementView(viewType: 'videoElement'),
        ),
      ),
    );
  }
}
