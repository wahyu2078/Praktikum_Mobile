// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'email', 'created_at'],
    disallowNullValues: const ['id', 'name', 'email', 'created_at'],
  );
  return User(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    email: json['email'] as String,
    createdAt: parseDateTime(json['created_at']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'created_at': dateTimeToJson(instance.createdAt),
};
