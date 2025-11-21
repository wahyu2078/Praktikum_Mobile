import 'user.dart';

void main() {
  print('=== DEBUG: Check JSON Structure ===');

  // Object Dart → JSON
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

  // JSON test (gunakan field yang sama / createdAt beda format)
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'createdAt': '2024-01-01T10:00:00.000Z',
  };

  print('JSON data to parse: $jsonData');
  print('JSON keys: ${jsonData.keys.toList()}');
  print('id: ${jsonData['id']} (type: ${jsonData['id'].runtimeType})');
  print('name: ${jsonData['name']} (type: ${jsonData['name'].runtimeType})');
  print('email: ${jsonData['email']} (type: ${jsonData['email'].runtimeType})');
  print(
    'createdAt: ${jsonData['createdAt']} (type: ${jsonData['createdAt'].runtimeType})',
  );

  print('\n=== Convert JSON to User Object ===');

  try {
    User userFromJson = User.fromJson(jsonData);
    print('SUCCESS: User from JSON: $userFromJson');
  } catch (e, stack) {
    print('❌ ERROR: $e');
    print('Stack trace: $stack');
  }

  print('\n=== TEST: Handle Missing Fields ===');

  // Test JSON tidak lengkap
  Map<String, dynamic> incompleteJson = {
    'id': 3,
    // name missing
    'email': 'test@example.com',
    // createdAt missing
  };

  try {
    User userFromIncomplete = User.fromJson(incompleteJson);
    print('User from incomplete JSON: $userFromIncomplete');
  } catch (e) {
    print('❌ Error with incomplete JSON: $e');
  }
}