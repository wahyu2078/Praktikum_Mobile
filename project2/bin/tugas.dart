import 'dart:io';

void main() {
  // Map untuk menyimpan data mahasiswa
  Map<String, int> nilaiMahasiswa = {};

  // Input nilai untuk 5 mahasiswa
  for (int i = 1; i <= 5; i++) {
    stdout.write("Masukkan nama mahasiswa ke-$i: ");
    String? nama = stdin.readLineSync();

    stdout.write("Masukkan nilai ujian $nama: ");
    int? nilai = int.parse(stdin.readLineSync()!);

    nilaiMahasiswa[nama!] = nilai;
  }

  print("\n=== Daftar Nilai dan Kategori ===");
  // Menentukan kategori kelulusan
  nilaiMahasiswa.forEach((nama, nilai) {
    String kategori;

    if (nilai >= 80) {
      kategori = 'A';
    } else if (nilai >= 60) {
      kategori = 'B';
    } else {
      kategori = 'C';
    }

    print("$nama : Nilai = $nilai, Kategori = $kategori");
  });
}
