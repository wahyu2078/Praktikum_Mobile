// lib/profile_page.dart

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Data Mata Kuliah Semester 5
  final List<String> mataKuliah = const [
    'Pemrograman Mobile',
    'Perencanaan Sumber Daya',
    'Manajemen Proyek Sistem Informasi',
    'Kecerdasan Bisnis',
    'Audit Sistem Informasi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bagian Header Profil
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue[50],
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    // Asumsi file avatar.png ada di assets/images/
                    backgroundImage: AssetImage('assets/image/avatar.png'),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Wahyu Trisnantoadi Prakoso',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'NIM: 2341760153 - Semester 5',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Informasi Kontak (Menggunakan Row)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  InfoCard(icon: Icons.email, label: 'Email'),
                  InfoCard(icon: Icons.phone, label: 'Telepon'),
                  InfoCard(icon: Icons.location_on, label: 'Alamat'),
                ],
              ),
            ),

            const Divider(),

            // Daftar Mata Kuliah (Menggunakan ListView)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '📚 Mata Kuliah Semester 5',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Menggunakan Container dengan tinggi tetap untuk ListView
            // agar bisa dimasukkan dalam SingleChildScrollView/Column
            Container(
              height: 300,
              child: ListView.builder(
                // ListView untuk daftar yang bisa di-scroll
                itemCount: mataKuliah.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: Text(mataKuliah[index]),
                  );
                },
              ),
            ),

            const Divider(),

            // Tombol Navigasi ke Galeri
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Lihat Galeri'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                // Navigasi menggunakan Named Routes
                onPressed: () {
                  Navigator.pushNamed(context, '/gallery');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Pembantu untuk Info Kontak
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoCard({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue[600]),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
