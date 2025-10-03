Function buatDiskon() {
  var diskon = 0;
  return () {
    diskon += 5;
    return diskon;
  };
}

void main() {
  var hitungDiskon = buatDiskon();

  print("Diskon pertama: ${hitungDiskon()}%");
  print("Diskon kedua: ${hitungDiskon()}%");
  print("Diskon ketiga: ${hitungDiskon()}%");
}
