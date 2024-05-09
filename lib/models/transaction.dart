class Transaction {
  int? id;

  Transaction();

  factory Transaction.fromJson(dynamic json) => Transaction();

  Map<String, dynamic> toJson() {
    return Map();
  }
}