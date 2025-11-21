import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WireMockApp());
}

class WireMockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	return MaterialApp(
	  title: 'WireMock Cloud Demo',
	  theme: ThemeData(primarySwatch: Colors.indigo),
	  home: UserPage(),
	);
  }
}

class ApiConfig {
  static const String baseUrl = 'https://wahyu.wiremockapi.cloud';
  static const String usersEndpoint = '/users';

  static Map<String, String> headers = {
	'Content-Type': 'application/json',
	'Accept': 'application/json',
  };
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<dynamic> users = [];
  bool isLoading = false;
  String? errorMessage;
  String? postMessage;

  @override
  void initState() {
	super.initState();
	fetchUsers();
  }

  // ============================
  // GET USERS (Diperbaiki: Menangani jika respons bukan List)
  // ============================
  Future<void> fetchUsers() async {
	setState(() {
	  isLoading = true;
	  errorMessage = null;
	});

	final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');

	try {
	  final response = await http
		  .get(url, headers: ApiConfig.headers)
		  .timeout(const Duration(seconds: 10));

	  if (response.statusCode == 200) {
		final decodedData = jsonDecode(response.body);

		// <<< PERBAIKAN UTAMA: Memastikan data adalah List (Array)
		if (decodedData is List) {
		  setState(() => users = decodedData);
		} else {
		  // Kasus di mana Stub WireMock mengembalikan Map tunggal atau data non-List
		  setState(() {
			users = []; // Kosongkan daftar agar tidak terjadi Type Error
			errorMessage = "Error: Data daftar pengguna tidak valid atau kosong.";
		  });
		}
		// >>>

	  } else {
		setState(() => errorMessage = "Error mengambil data: ${response.statusCode}");
	  }
	} catch (e) {
	  setState(() => errorMessage = "Error koneksi: $e");
	} finally {
	  setState(() => isLoading = false);
	}
  }

  // ============================
  // POST ADD USER (Diperbaiki: Menangani pesan sukses/gagal secara lebih jelas)
  // ============================
  Future<void> addUser() async {
	final name = _nameController.text.trim();
	final email = _emailController.text.trim();

	if (name.isEmpty || email.isEmpty) {
	  ScaffoldMessenger.of(context).showSnackBar(
		SnackBar(content: Text("Nama & Email tidak boleh kosong!")),
	  );
	  return;
	}

	final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');
	final body = jsonEncode({"name": name, "email": email});

	try {
	  final response = await http
		  .post(url, headers: ApiConfig.headers, body: body)
		  .timeout(const Duration(seconds: 10));

	  if (response.statusCode == 200 || response.statusCode == 201) {
		final data = jsonDecode(response.body);

		// Menggunakan nilai dari "message" jika ada, jika tidak, gunakan default
		setState(() {
		  postMessage = data is Map && data.containsKey("message") 
			? data["message"] 
			: "User berhasil ditambahkan!";
		});

		ScaffoldMessenger.of(
		  context,
		).showSnackBar(SnackBar(content: Text(postMessage!)));

		_nameController.clear();
		_emailController.clear();

		fetchUsers(); // Panggil fetchUsers setelah sukses
	  } else {
		// Menangani pesan error dari API jika statusnya 4xx/5xx
		String apiError = "Gagal menambah user (${response.statusCode})";
		try {
		  final data = jsonDecode(response.body);
		  if (data is Map && data.containsKey("message")) {
			apiError = data["message"];
		  }
		} catch (_) {
		  // Biarkan apiError default jika body bukan JSON atau kosong
		}
		
		setState(() {
		  postMessage = apiError;
		});
	  }
	} catch (e) {
	  setState(() => postMessage = "Error koneksi: $e");
	}
  }

  // ============================
  // UI (Tidak ada perubahan di sini)
  // ============================
  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(title: const Text("WireMock Cloud - Users")),
	  body: Padding(
		padding: const EdgeInsets.all(16),
		child: Column(
		  children: [
			// Input Name
			TextField(
			  controller: _nameController,
			  decoration: const InputDecoration(
				labelText: "Nama",
				border: OutlineInputBorder(),
			  ),
			),
			SizedBox(height: 8),

			// Input Email
			TextField(
			  controller: _emailController,
			  decoration: const InputDecoration(
				labelText: "Email",
				border: OutlineInputBorder(),
			  ),
			),
			SizedBox(height: 10),

			ElevatedButton.icon(
			  onPressed: addUser,
			  icon: Icon(Icons.add),
			  label: Text("Tambah User"),
			),
			SizedBox(height: 20),

			if (postMessage != null)
			  Container(
				width: double.infinity,
				padding: EdgeInsets.all(12),
				decoration: BoxDecoration(
				  // Menggunakan warna merah untuk pesan error dan hijau untuk pesan sukses
				  color: postMessage!.contains("Gagal") || postMessage!.contains("Error") ? Colors.red[50] : Colors.green[50],
				  border: Border.all(color: postMessage!.contains("Gagal") || postMessage!.contains("Error") ? Colors.red : Colors.green),
				  borderRadius: BorderRadius.circular(8),
				),
				child: Text(
				  postMessage!,
				  style: TextStyle(
					color: postMessage!.contains("Gagal") || postMessage!.contains("Error") ? Colors.red : Colors.green,
					fontWeight: FontWeight.bold,
				  ),
				),
			  ),

			Divider(height: 30),
			Text(
			  "Daftar User",
			  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
			),
			Divider(),

			Expanded(
			  child: isLoading
				  ? Center(child: CircularProgressIndicator())
				  : errorMessage != null
				  ? Center(child: Text(errorMessage!))
				  : users.isEmpty
				  ? Center(child: Text("Belum ada data."))
				  : ListView.builder(
					  itemCount: users.length,
					  itemBuilder: (context, index) {
						final user = users[index];
						return ListTile(
						  leading: CircleAvatar(child: Text("${user['id']}")),
						  title: Text(user["name"]),
						  subtitle: Text(user["email"]),
						);
					  },
					),
			),
		  ],
		),
	  ),

	  floatingActionButton: FloatingActionButton(
		onPressed: fetchUsers,
		child: const Icon(Icons.refresh),
	  ),
	);
  }
}