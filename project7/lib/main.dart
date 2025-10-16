import 'package:flutter/material.dart';

// Halaman Utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ke Halaman Kedua'),
          onPressed: () {
            // Navigator.push: Menambah rute baru ke stack
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
        ),
      ),
    );
  }
}

// Halaman Kedua
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Kedua')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Kembali'),
          // Navigator.pop: Menghapus rute paling atas dari stack (kembali)
          onPressed: () => Navigator.pop(context), 
        ),
      ),
    );
  }
}

// Untuk menjalankan contoh ini:
void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}