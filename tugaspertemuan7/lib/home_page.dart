// lib/home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kampus'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        // Center widget menempatkan konten di tengah layar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang di Portal Mahasiswa',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Kelola data profil, mata kuliah, dan galeri Anda.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Tombol untuk navigasi ke halaman profil
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Lihat Profil Saya'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navigasi ke halaman profil menggunakan Named Route
                // Rute '/' telah didaftarkan di routes.dart untuk ProfilePage
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
