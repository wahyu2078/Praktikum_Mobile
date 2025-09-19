import 'dart:io';

import 'package:project3/project3.dart' as project3;

void main(List<String> arguments) {
  // print('Hello world: ${project3.calculate()}!');

  var fl = List<int>.filled(4,2);
  List <int> angka = [1,2,3,4,5,6,7,8,9,10];
  fl[0] = 0;
  fl[1] = 1;
  fl[2] = 2;
  fl[3] = 3;
  fl[4] = 4;
  fl[5] = 5;

  // cetak
  stdout.writeln(fl);
}
