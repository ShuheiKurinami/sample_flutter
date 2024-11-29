// lib/models/user.dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String sex;
  final String address;
  final DateTime created_at;
  final DateTime updated_at;

  User({
    required this.id,
    required this.name,
    required this.sex,
    required this.address,
    required this.created_at,
    required this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
