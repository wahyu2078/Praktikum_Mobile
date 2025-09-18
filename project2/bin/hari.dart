import 'dart:io';

void main() {
  // print('coba');
  print("Masukkan angka hari =");
  String? hari = stdin.readLineSync();
  int nilai = int.tryParse(hari ?? '') ?? 0;
  switch (nilai) {
    case 1:
      print("senin");
      break;
    case 2:
      print("selasa");
      break;
    case 3:
      print("rabu");
      break;
    default:
      print("maaf inputan salah");
  }
}