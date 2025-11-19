import 'dart:io';

void main(List<String> arguments) {
  // print('Hello world: ${calculate()}!');
  var map = {'nim': "2341760153", 'nama': "wahyu", 'umur': 20};
  print(map);
  print(map['nim']);

  var opo = {
    'nim': ["101", "102"],
    'nama': ["andi", "budi"],
    'umur': [20, 21],
  };
  print(opo);
  print(opo['nama']);
}
