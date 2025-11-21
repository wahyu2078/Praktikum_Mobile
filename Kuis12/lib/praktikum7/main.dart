import 'package:encrypt/encrypt.dart';
import 'dart:convert';

void main() {
  // 1. Buat key dan IV (CBC butuh key 16/24/32 dan IV 16 bytes)
  final key = Key.fromUtf8('0123456789ABCDEF0123456789ABCDEF'); // 32 char = 256-bit
  final iv = IV.fromUtf8('0123456789ABCDEF'); // 16 char

  // 2. Buat encrypter AES CBC
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  // 3. Contoh text biasa
  final plainText = 'Ini rahasia besar saya';
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print('Encrypted (base64): ${encrypted.base64}');

  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('Decrypted text: $decrypted');

  // 4. Contoh enkripsi data JSON
  final data = {
    'user': 'wahyu',
    'token': 'abc123xyz',
  };

  final jsonString = jsonEncode(data);
  final encryptedJson = encrypter.encrypt(jsonString, iv: iv);

  print('Encrypted JSON (base64): ${encryptedJson.base64}');

  final decryptedJson = encrypter.decrypt(encryptedJson, iv: iv);
  print('Decrypted JSON: $decryptedJson');
}