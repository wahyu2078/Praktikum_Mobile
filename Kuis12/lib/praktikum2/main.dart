import 'user.dart';

void main() {
  print('=== DEBUG: Check JSON Structure ===');

  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> userJson = user.toJson();
  print('User.toJson() result: $userJson');
  print('Field names: ${userJson.keys.toList()}');

  print('\n=== TEST: JSON to Object ===');

  // Gunakan field names yang sama dengan hasil toJson()
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'created_at': '2024-01-01T10:00:00.000Z',
  };

  print('JSON data to parse: $jsonData');
  print('JSON keys: ${jsonData.keys.toList()}');

  print('id: ${jsonData['id']} (type: ${jsonData['id'].runtimeType})');
  print('name: ${jsonData['name']} (type: ${jsonData['name'].runtimeType})');
  print('email: ${jsonData['email']} (type: ${jsonData['email'].runtimeType})');
  print('created_at: ${jsonData['created_at']} (type: ${jsonData['created_at'].runtimeType})');

  print('\n=== Convert JSON to User Object ===');
  User user2 = User.fromJson(jsonData);

  print('Parsed User:');
  print('id: ${user2.id}');
  print('name: ${user2.name}');
  print('email: ${user2.email}');
  print('createdAt: ${user2.createdAt}');
}