import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AppSettings {
  bool isDarkMode = false;
  String userName = "Teman";
  int fontSize = 20;

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.grey[900]!;
  }

  String get greeting {
    return "Halo, $userName!";
  }

  @override
  String toString() {
    return 'AppSettings{isDarkMode: $isDarkMode, userName: $userName, fontSize: $fontSize}';
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppSettings settings = AppSettings();

  void toggleDarkMode() {
    setState(() {
      settings.isDarkMode = !settings.isDarkMode;
    });
  }

  void updateName(String newName) {
    setState(() {
      settings.userName = newName;
    });
  }

  void increaseFontSize() {
    setState(() {
      settings.fontSize += 1;
    });
  }

  void decreaseFontSize() {
    setState(() {
      settings.fontSize -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: settings.backgroundColor,
        appBar: AppBar(
          title: Text('Aplikasi Settings Sederhana'),
          backgroundColor: settings.isDarkMode
              ? Colors.blueGrey[800]
              : Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                settings.greeting,
                style: TextStyle(
                  fontSize: settings.fontSize.toDouble(),
                  color: settings.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode
                      ? Colors.blueGrey[700]
                      : Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: TextStyle(fontSize: 18, color: settings.textColor),
                    ),
                    Switch(
                      value: settings.isDarkMode,
                      onChanged: (value) => toggleDarkMode(),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              TextField(
                onChanged: updateName,
                decoration: InputDecoration(
                  labelText: 'Ubah Nama',
                  labelStyle: TextStyle(color: settings.textColor),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: settings.isDarkMode
                      ? Colors.grey[800]
                      : Colors.grey[100],
                ),
                style: TextStyle(color: settings.textColor),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
