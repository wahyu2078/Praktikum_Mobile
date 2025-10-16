import 'package:flutter/material.dart';

void main() {
  runApp(const MyStatelessApp()); 
}

class MyStatelessApp extends StatelessWidget {
  const MyStatelessApp({super.key}); // Menggunakan StatelessWidget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Stateless Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contoh Stateless Widget',
          ), // Contoh tampilan statis
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            'Wahyu Trisnantoadi Prakoso',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
