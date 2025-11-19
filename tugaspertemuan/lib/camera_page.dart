import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  XFile? pictureFile;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    initCamera(selectedCameraIndex);
  }

  Future<void> initCamera(int cameraIndex) async {
    if (widget.cameras.isEmpty) {
      print("Tidak ada kamera yang tersedia");
      return;
    }

    _controller = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print("Gagal instalasi kamera: $e");
    }
  }

  Future<void> switchCamera() async {
    if (widget.cameras.length < 2) {
      print("tidak ada kamera depan/belakang yang tersedia");
      return;
    }

    selectedCameraIndex = (selectedCameraIndex + 1) % widget.cameras.length;

    await _controller?.dispose();
    await initCamera(selectedCameraIndex);
  }

  Future<void> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (_controller!.value.isTakingPicture) return;

    try {
      final XFile file = await _controller!.takePicture();

      setState(() {
        pictureFile = file;
      });
  //untuk menampilkan snack bar
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Path: ${file.path}"),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      print("Error saat mengambil foto : $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: switchCamera,
            tooltip: "Ganti Kamera",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller!)),
          if (pictureFile != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.file(File(pictureFile!.path), height: 100),
            ),
          ElevatedButton(
            onPressed: takePicture,
            child: const Text("Ambil gambar"),
          ),
        ],
      ),
    );
  }
}