import 'package:tricount/models/enums.dart';
import 'package:tricount/models/transaction.dart';
import 'package:tricount/models/user.dart';

class Tricount {
  int? id;
  final DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  TricountLabel label;
  Currency currency;
  Uri? uri;
  List<User> users = [];
  List<Transaction> transactions = [];
  User owner;

  Tricount({
    required this.owner,
    required this.currency,
    required this.label
    });
}