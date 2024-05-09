import 'package:dio/dio.dart';
import 'package:tricount/services/api_service.dart';

class TricountProvider {
  final ApiService _api = ApiService.instance;


  Future<Response> getUserTricounts() async {
    final Response response = await _api.get("/tricounts");
    return response;
  }
}