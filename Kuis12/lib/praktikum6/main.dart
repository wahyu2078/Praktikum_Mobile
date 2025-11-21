import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileService {
  Future<Directory> get directory async => await getApplicationDocumentsDirectory();

  Future<File> write(String fileName, String content) async {
    final dir = await directory;
    final file = File(path.join(dir.path, fileName));
    return file.writeAsString(content);
  }

  Future<String> read(String fileName) async {
    try {
      final dir = await directory;
      final file = File(path.join(dir.path, fileName));
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  Future<bool> exists(String fileName) async {
    final dir = await directory;
    final file = File(path.join(dir.path, fileName));
    return await file.exists();
  }

  Future<void> delete(String fileName) async {
    final dir = await directory;
    final file = File(path.join(dir.path, fileName));
    if (await file.exists()) await file.delete();
  }
}

class DirectoryService {
  final FileService fileService = FileService();

  Future<Directory> create(String dirName) async {
    final appDir = await fileService.directory;
    final newDir = Directory(path.join(appDir.path, dirName));
    if (!await newDir.exists()) await newDir.create(recursive: true);
    return newDir;
  }
}

class NoteService {
  final DirectoryService dirService = DirectoryService();
  final String notesDir = 'notes';

  Future<void> saveNote({
    required String title,
    required String content,
  }) async {
    final dir = await dirService.create(notesDir);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File(path.join(dir.path, fileName));

    final data = {
      'title': title,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    };

    await file.writeAsString(jsonEncode(data));
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final dir = await dirService.create(notesDir);
    final files = dir.listSync();
    List<Map<String, dynamic>> notes = [];

    for (var f in files) {
      if (f is File && f.path.endsWith(".json")) {
        final content = await f.readAsString();
        final data = jsonDecode(content);
        data['file_path'] = f.path;
        notes.add(data);
      }
    }

    notes.sort((a, b) => b['created_at'].compareTo(a['created_at']));
    return notes;
  }

  Future<void> deleteByPath(String pathFile) async {
    final file = File(pathFile);
    if (await file.exists()) await file.delete();
  }
}

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final data = await noteService.getNotes();
    setState(() => notes = data);
  }

  Future<void> addNote() async {
    final ok = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddNotePage()),
    );
    if (ok == true) loadNotes();
  }

  Future<void> deleteNote(String path) async {
    await noteService.deleteByPath(path);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: notes.isEmpty
          ? Center(child: Text("Belum ada catatan."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final n = notes[i];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(n['title']),
                    subtitle: Text(
                      n['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteNote(n['file_path']),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailPage(note: n),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNotePage extends StatefulWidget {
  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  final NoteService noteService = NoteService();
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  Future<void> save() async {
    if (titleCtrl.text.isEmpty || contentCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Isi semua field!")),
      );
      return;
    }

    await noteService.saveNote(
      title: titleCtrl.text,
      content: contentCtrl.text,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan Baru')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Isi Catatan'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: save,
              icon: Icon(Icons.save),
              label: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}

class NoteDetailPage extends StatelessWidget {
  final Map<String, dynamic> note;
  const NoteDetailPage({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note['title'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(note['content']),
      ),
    );
  }
}