// lib/gallery_page.dart

import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Daftar gambar di assets/images/
  final List<String> images = const [
    'assets/image/pic1.jpg',
    'assets/image/pic2.jpg',
    'assets/image/avatar.png', // Contoh menggunakan avatar juga
    // Tambahkan lebih banyak item jika perlu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri'),
        backgroundColor: Colors.green[800],
      ),
      // GridView untuk tata letak kotak-kotak
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount:
            images.length *
            3, // Menggandakan untuk contoh galeri yang lebih banyak
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final imagePath = images[index % images.length];
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                // Tambahkan aksi ketika gambar diklik (misalnya, zoom)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gambar ke ${index + 1} diklik!')),
                );
              },
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
