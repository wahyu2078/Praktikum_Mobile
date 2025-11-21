import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(PokeApp());
}

class PokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: PokemonPage(),
    );
  }
}

class PokemonPage extends StatefulWidget {
  @override
  PokemonPageState createState() => PokemonPageState();
}

class PokemonPageState extends State<PokemonPage> {
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/arceus'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        setState(() {
          pokemonData = jsonDecode(response.body);
        });
      } else {
        setState(() {
          error = 'Gagal memuat data. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Terjadi kesalahan: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PokeAPI')),
      body: Center(child: _buildPokemonCard()),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchPokemon,
        child: const Icon(Icons.refresh),
        tooltip: 'Refresh Data',
      ),
    );
  }

  Widget _buildPokemonCard() {
    // loading
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    // error
    if (error != null) {
      return Text(error!, style: const TextStyle(color: Colors.red));
    }

    // belum ada data
    if (pokemonData == null) {
      return const Text("Tidak ada data.");
    }

    // data tersedia
    final name = pokemonData!['name'] ?? '-';
    final id = pokemonData!['id'] ?? '-';
    final height = pokemonData!['height'] ?? '-';
    final weight = pokemonData!['weight'] ?? '-';
    final sprite = pokemonData!['sprites']?['front_default'] ??
        'https://via.placeholder.com/150';

    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(sprite, width: 150, height: 150),
            const SizedBox(height: 10),
            Text(
              name.toString().toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text('ID: $id'),
            Text('Height: $height'),
            Text('Weight: $weight'),
          ],
        ),
      ),
    );
  }
}
