void main(List<String> arguments) {
  // Growable List kosong
  var mahasiswa = <String>[];

  // Tambahkan data
  mahasiswa.add("Renal");
  mahasiswa.add("Satria");
  mahasiswa.add("Wahyu");
  mahasiswa.add("wahyi");

  // Tampilkan isi list
  print("Daftar mahasiswa: $mahasiswa");

  // Tampilkan jumlah data
  print("Jumlah mahasiswa: ${mahasiswa.length}");
}
