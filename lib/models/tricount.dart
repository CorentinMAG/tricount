import 'dart:typed_data';

import 'package:tricount/models/enums.dart';
import 'package:tricount/models/transaction.dart';
import 'package:tricount/models/user.dart';

class Tricount {
  int? id;

  String title;
  String? description;

  DateTime createdAt;
  DateTime? updatedAt;

  TricountLabel label;
  Currency currency;
  String? uri;

  List<UserModel> users;
  List<Transaction> transactions;
  UserModel owner;

  String? joinUri;

  String? imageName;
  int? imageSize;

  Uint8List? image;

  Tricount(
      {required this.title,
      required this.owner,
      required this.currency,
      required this.label,
      this.id,
      this.updatedAt,
      this.description,
      this.uri,
      this.imageName,
      this.imageSize,
      this.joinUri,
      DateTime? createdAt,
      List<UserModel>? users,
      List<Transaction>? transactions})
      : createdAt = createdAt ?? DateTime.now(),
        users = users ?? [],
        transactions = transactions ?? [];

  static Tricount empty(UserModel owner) {
    return Tricount(
      title: "",
      owner: owner,
      currency: Currency.euro,
      label: TricountLabel.event,
    );
  }

  factory Tricount.fromJson(dynamic json) => Tricount(
      id: json["id"],
      owner: UserModel.fromJson(json['owner']),
      currency: Currency.values[json['currency']['id'] - 1],
      label: TricountLabel.values[json['label']['id'] - 1],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      description: json['description'],
      title: json['title'],
      uri: json['uri'],
      imageName: json['imageName'],
      imageSize: json['imageSize'],
      joinUri: json['joinUri'],
      users: (json['users'] as List<dynamic>)
          .map<UserModel>((e) => UserModel.fromJson(e))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map<Transaction>((e) => Transaction.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "uri": uri,
        "imageName": imageName,
        "imageSize": imageSize,
        "users": users,
        "owner": owner,
        "transactions": transactions,
        "currency": currency.index + 1,
        "label": label.index + 1,
        "joinUri": joinUri
      };

  @override
  String toString() {
    return "{id: $id, title: $title, description: $description, createdAt: $createdAt, owner: ${owner.username}}";
  }
}
