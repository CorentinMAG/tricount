import 'package:crypto/crypto.dart';
import 'dart:convert';
class UserModel {
  int? id;
  String username;
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  String email;
  String country = "FR";
  String? lastLoginIp;
  DateTime? lastLoginAt;
  String avatar;
  int googleId;

  UserModel({
    this.id,
    required this.email,
    required this.username,
    required this.googleId,
    avatar
  })
  : avatar = avatar ?? "https://gravatar.com/avatar/${sha256.convert(utf8.encode(email))}.jpg?s=200&d=identicon";


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    avatar: json["avatar"],
    googleId: json["googleId"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "avatar": avatar,
    "googleId": googleId
  };

}