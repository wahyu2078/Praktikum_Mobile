import 'dart:io';

import 'package:project3/project3.dart' as project3;

void main(List<String> arguments) {
  // print('Hello world: ${project3.calculate()}!');

  // var fl = List<int>.filled(4,2);
  // List <int> angka = [1,2,3,4,5,6,7,8,9,10];
  // fl[0] = 0;
  // fl[1] = 1;
  // fl[2] = 2;
  // fl[3] = 3;
  // fl[4] = 4;
  // fl[5] = 5;

  // cetak

  //growable
  // var gl = [1,2,3];
  // gl.add(18);
  // gl.remove(2);
  // stdout.writeln(gl);
    
  // var setNilai1 = <int>{};
  // var setNilai2 = <int>{3,3,4,5};
  // // print(setNilai2);
  // print(setNilai1.union(setNilai2));
  // print(setNilai2.intersection(setNilai1));

  var setNilai1 = <String>{};
  stdout.writeln('jumlah nilai : ');
  String? input1 = stdin.readLineSync();
    int jumlah1 = (int.tryParse(input1 ?? ''))?? 0;
    for (var i = 0; i < jumlah1; i++) {
      stdout.writeln('masukkan nilai ${i + 1} :  ');
      String? input2 = stdin.readLineSync();
      String nilai = input2 ?? '';
      setNilai1.add(nilai);
    }
    var nilaiList = setNilai1.toList();
    print(nilaiList[1]);
}




