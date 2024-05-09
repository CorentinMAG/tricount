import 'package:tricount/models/tricount.dart';
import 'package:tricount/provider/tricount_provider.dart';

class TricountRepository {
  final TricountProvider _provider = TricountProvider();


  Future<List<Tricount>> getUserTricounts() async {
    final response = await _provider.getUserTricounts();
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    } else {
      final List<dynamic> data = response.data;
      final tricounts = data.map((e) => Tricount.fromJson(e)).toList();
      return tricounts;
    }
   }
}