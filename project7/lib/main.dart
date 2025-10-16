import 'package:flutter/material.dart';

void main() {
  runApp(const StackExample());
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Stack',
      home: Scaffold(
        appBar: AppBar(title: const Text('Contoh Stack')),
        body: Center(
          // Stack: Menumpuk widget satu di atas yang lain
          child: Stack(
            alignment: Alignment.center, // Menyusun semua children ke tengah
            children: [
              // Container paling bawah (lapisan 1)
              Container(
                width: 200,
                height: 200,
                color: Colors.blue[100],
              ),
              // Container di tengah (lapisan 2)
              Container(
                width: 150,
                height: 150,
                color: Colors.blue[300],
              ),
              // Text paling atas (lapisan 3)
              const Text(
                'Tumpuk!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
