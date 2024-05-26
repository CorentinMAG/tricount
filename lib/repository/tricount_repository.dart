import 'package:tricount/models/tricount.dart';
import 'package:tricount/provider/tricount_provider.dart';

class TricountRepository {
  final TricountProvider _provider = TricountProvider();


  Future<List<Tricount>> fetch() async {
    final response = await _provider.getUserTricounts();
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    } else {
      final List<dynamic> data = response.data;
      final tricounts = data.map((e) => Tricount.fromJson(e)).toList();
      return tricounts;
    }
  }

  Future<Tricount> save(Tricount tricount) async {
    final response = await _provider.upsert(tricount);
    if (response.statusCode != 201) {
      throw Exception(response.toString());
    } else {
      final data = response.data;
      print(data);
      return Tricount.fromJson(data);
    }
  }

  Future<void> delete(int id) async {
    final response = await _provider.delete(id);
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    }
  }
}