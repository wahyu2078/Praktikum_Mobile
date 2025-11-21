import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// FileService
class FileService {
  Future<Directory> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> writeFile(String fileName, String content) async {
    final dir = await documentsDirectory;
    final file = File(path.join(dir.path, fileName));
    return file.writeAsString(content);
  }

  Future<String> readFile(String fileName) async {
    try {
      final dir = await documentsDirectory;
      final file = File(path.join(dir.path, fileName));
      return await file.readAsString();
    } catch (_) {
      return '';
    }
  }

  Future<File> writeJson(String fileName, Map<String, dynamic> json) async {
    return writeFile(fileName, jsonEncode(json));
  }

  Future<Map<String, dynamic>> readJson(String fileName) async {
    try {
      final content = await readFile(fileName);
      return jsonDecode(content);
    } catch (_) {
      return {};
    }
  }

  Future<bool> fileExists(String fileName) async {
    final dir = await documentsDirectory;
    final file = File(path.join(dir.path, fileName));
    return file.exists();
  }

  Future<void> deleteFile(String fileName) async {
    try {
      final dir = await documentsDirectory;
      final file = File(path.join(dir.path, fileName));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }
}

// UserDataService
class UserDataService {
  final FileService _fileService = FileService();
  final String _fileName = 'user_data.json';

  Future<void> saveUserData({
    required String name,
    required String email,
    int? age,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'age': age ?? 0,
      'last_update': DateTime.now().toIso8601String(),
    };

    await _fileService.writeJson(_fileName, data);
  }

  Future<Map<String, dynamic>?> readUserData() async {
    final exists = await _fileService.fileExists(_fileName);
    if (!exists) return null;

    final data = await _fileService.readJson(_fileName);
    return data.isNotEmpty ? data : null;
  }

  Future<void> deleteUserData() async {
    await _fileService.deleteFile(_fileName);
  }

  Future<bool> hasUserData() async {
    return await _fileService.fileExists(_fileName);
  }
}

// MAIN
void main() {
  runApp(MyApp());
}

// MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data JSON Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: UserProfilePage(),
    );
  }
}

// UserProfilePage
class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  final UserDataService _userService = UserDataService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Map<String, dynamic>? _savedData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _userService.readUserData();
    setState(() => _savedData = data);
  }

  Future<void> _saveUserData() async {
    await _userService.saveUserData(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      age: int.tryParse(_ageController.text),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));

    await _loadUserData();
  }

  Future<void> _deleteUserData() async {
    await _userService.deleteUserData();
    setState(() => _savedData = null);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data user dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil User (File JSON)")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: "Usia",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text("Simpan"),
                  onPressed: _saveUserData,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Hapus"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: _deleteUserData,
                ),
              ],
            ),

            SizedBox(height: 30),
            Divider(),

            _savedData == null
                ? Text(
                    "Belum ada data tersimpan.",
                    style: TextStyle(color: Colors.grey),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Tersimpan:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildDataRow("Nama", _savedData!['name']),
                      _buildDataRow("Email", _savedData!['email']),
                      _buildDataRow("Usia", _savedData!['age'].toString()),
                      _buildDataRow(
                        "Update Terakhir",
                        _savedData!['last_update'],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}