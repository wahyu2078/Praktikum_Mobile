import 'dart:io';
import 'package:pertemuan3/pertemuan3.dart' as pertemuan3;

const String nama = "Wahyu";

void main(List<String> arguments) {
  // print('Hello world: ${pertemuan3.calculate()}!');
  //satu line comment
  /*
  multi line comment
  banyak line comment
  */

  // constanta dan final
  final String nama2 = 'Wahyi'; 

  print("Nama saya $nama $nama2");

  // variable
  int umur = 20;
  double tinggi = 173.5;
  bool jenisKelamin = true; // true = laki-laki, false = perempuan
  String alamat = "Jl. Titan 5";

  stdout.writeln("Umur saya $umur");
  stdout.writeln("Tinggi saya $tinggi");
  stdout.writeln("Jenis kelamin saya ${jenisKelamin ? 'laki-laki' : 'perempuan'}");
  // if (jenisKelamin) {
  //   stdout.writeln("Jenis kelamin saya laki-laki");
  // } else {
  //   stdout.writeln("Jenis kelamin saya perempuan");
  // }
  stdout.writeln("Alamat saya $alamat");
}
