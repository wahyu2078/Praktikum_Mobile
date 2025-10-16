import 'package:flutter/material.dart';

void main() {
  runApp(const SingleChildExample());
}

class SingleChildExample extends StatelessWidget {
  const SingleChildExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Single Child Layout Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Single Child Layout Example'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            color: Colors.lightGreen,
            child: const Text(
              'Hello Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
