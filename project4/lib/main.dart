import 'package:flutter/material.dart';

void main() {
  runApp(LuqmanApp());
}

class LuqmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Luqman App",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Balonku ada 5",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: false,
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Balonku ada 5\nRupa-rupa warnanya\nHijau, kuning, kelabu\nMerah muda dan biru",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Meletus balon hijau\nHatiku sangat kacau\nBalonku tinggal 4\nKupegang erat-erat",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontFamily: 'Arial',
              ),
            ),
          ],
        ),
     ),
  );
}
}