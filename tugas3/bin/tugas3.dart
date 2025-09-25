void main() {
  var barang = <String, Map<String, dynamic>>{};

  // Tambah minimal 3 barang
  barang["B001"] = {"nama": "Pensil", "harga": 2000};
  barang["B002"] = {"nama": "Buku", "harga": 5000};
  barang["B003"] = {"nama": "Penghapus", "harga": 1500};

  // Tampilkan data barang
  print("Data barang:");
  barang.forEach((kode, data) {
    print("Kode: $kode, Nama: ${data['nama']}, Harga: Rp${data['harga']}");
  });
}
