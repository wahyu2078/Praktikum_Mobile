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
  num nilai = 90.5; //bisa di isi dengan int atau double
  stdout.writeln("Nilai saya $nilai");

  dynamic bebas = "16";
  stdout.writeln("Nilai dari dynamic adalah $bebas");

  // String angka1 = "15";
  // int angka2 = int.parse(angka1);
  // int angka3 = bebas;

  // List 
  List<String> hobby = ["game", "mancing", "billard"];
  hobby.add("menyanyi");
  stdout.writeln("Hobby saya $hobby");

  Map<String, String> data = {
    "nama": "Wahyu",
    "alamat": "Jl. titan 5",
    "jenis_kelamin": "Laki-laki"
  };

  data['pekerjaan'] = "Mahasiswa";
  data.addAll({"umur": "20"});
  stdout.writeln("Data : $data");
  stdout.writeln("Nama saya ${data['nama']}");
  stdout.writeln("Alamat saya ${data['alamat']}");
  stdout.writeln("Jenis kelamin saya ${data['jenis_kelamin']}");

}
