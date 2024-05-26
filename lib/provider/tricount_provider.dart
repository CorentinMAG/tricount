import 'package:dio/dio.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/services/api_service.dart';

class TricountProvider {
  final ApiService _api = ApiService.instance;


  Future<Response> getUserTricounts() async {
    final Response response = await _api.get("/tricounts");
    return response;
  }

  Future<Response> upsert(Tricount tricount) async {
    if (tricount.id == null) {
      return _api.post("/tricounts", tricount.toJson(), formdata: true);
    } else {
      return _api.post("/tricounts/update", tricount.toJson());
    }
  }

  Future<Response> delete(int id) async {
    return _api.delete("/tricounts/$id");
  }
}