import 'package:crypto/crypto.dart';
import 'dart:convert';
class User {
  int? id;
  String username;
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  String email;
  String country = "FR";
  String? lastLoginIp;
  DateTime? lastLoginAt;
  String avatar;

  User({
    this.id,
    required this.email,
    required this.username,
    avatar
  })
  : avatar = avatar ?? "https://gravatar.com/avatar/${sha256.convert(utf8.encode(email))}.jpg?s=200&d=identicon";


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    avatar: json["avatar"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "avatar": avatar
  };

}