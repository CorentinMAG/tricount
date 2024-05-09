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

  String? imageName;
  int? imageSize;

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
      DateTime? createdAt,
      List<UserModel>? users,
      List<Transaction>? transactions})
      : createdAt = createdAt ?? DateTime.now(),
        users = users ?? [],
        transactions = transactions ?? [];

  factory Tricount.fromJson(dynamic json) => Tricount(
      id: json["id"],
      owner: UserModel.fromJson(json['owner']),
      currency: Currency.values[json['currency']['id'] - 1],
      label: TricountLabel.values[json['label']['id'] - 1],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      description: json['description'],
      title: json['title'],
      uri: json['uri'],
      imageName: json['imageName'],
      imageSize: json['imageSize'],
      users: (json['users'] as List<dynamic>).map<UserModel>((e) => UserModel.fromJson(e)).toList(),
      transactions: (json['transactions'] as List<dynamic>).map<Transaction>((e) => Transaction.fromJson(e)).toList()
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "uri": uri,
        "imageName": imageName,
        "imageSize": imageSize,
        "users": users,
        "owner": owner,
        "transactions": transactions,
        "currency": currency,
        "label": label
      };

  @override
  String toString() {
    return "{id: $id, title: $title, description: $description}";
  }
}
