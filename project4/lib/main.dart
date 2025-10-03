import 'package:flutter/material.dart';

void main() {
  runApp(WahyuApp());
}

class WahyuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Wahyu Demo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              fontFamily: 'Roboto',
            ),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Column(
          
        ),
      ),
    );
  }
}
