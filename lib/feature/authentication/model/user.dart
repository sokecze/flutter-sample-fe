import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;

  const User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
