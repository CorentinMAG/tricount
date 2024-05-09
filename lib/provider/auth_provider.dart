import 'package:dio/dio.dart';
import 'package:tricount/models/user.dart';
import 'package:tricount/services/api_service.dart';

class AuthenticationProvider {
  final ApiService _api = ApiService.instance;

  Future<Response> signUpUser({required UserModel user, required String password}) async {
    final Map<String, dynamic> payload = {
      "user": user.toJson(),
      "password": password
    };
    final Response response = await _api.post("/signup", payload);
    return response;
  }

  Future<Response> signInWithEmailAndPassword({required String email, required String password}) async {
    final Map<String, String> credentials = {
      "email": email,
      "password": password
    };
    final Response response = await _api.post("/signin/password", credentials);
    return response;

  }

  Future<Response> requestPasswordReset({required String email}) async {
    final Map<String, String> payload = {
      "email": email
    };
    final Response response = await _api.post("/reset/password", payload);
    return response;
  }
}