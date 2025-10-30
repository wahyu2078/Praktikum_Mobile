// lib/main.dart

import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      initialRoute: '/', // Mengatur rute awal
      routes: routes, // Mendaftarkan semua rute
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
