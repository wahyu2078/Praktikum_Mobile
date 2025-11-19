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
              // GREETING
              Text(
                settings.greeting,
                style: TextStyle(
                  fontSize: settings.fontSize.toDouble(),
                  color: settings.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              // DARK MODE
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

              SizedBox(height: 20),

              // TEXT FIELD GANTI NAMA
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

              // ================================
              //      UKURAN FONT + PREVIEW
              // ================================
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode
                      ? Colors.blueGrey[800]
                      : Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ukuran Font: ${settings.fontSize}',
                      style: TextStyle(color: settings.textColor, fontSize: 16),
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: decreaseFontSize,
                          icon: Icon(
                            Icons.remove_circle,
                            color: settings.textColor,
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: increaseFontSize,
                          icon: Icon(
                            Icons.add_circle,
                            color: settings.textColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // PREVIEW TEXT
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: settings.textColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Ini adalah preview text dengan ukuran font ${settings.fontSize}',
                        style: TextStyle(
                          fontSize: settings.fontSize.toDouble(),
                          color: settings.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: toggleDarkMode,
          child: Icon(settings.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          backgroundColor: settings.isDarkMode
              ? Colors.blueGrey[800]
              : Colors.blue,
        ),
      ),
    );
  }
}
