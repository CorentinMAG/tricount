import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tricount/services/shared_preferences_service.dart';
import 'package:tricount/utils/constants.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();
  late Dio _dio;

  ApiService._internal();

  Future<void> initialize() async {
    print("base uri: ${Environment.baseUrl.toString()}");
    final options = BaseOptions(
      baseUrl: Environment.baseUrl.toString(),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      validateStatus: (int? status) {
        return status != null;
      }
    );
    _dio = Dio(options);
    _dio.interceptors.addAll([
      AuthenticatedInterceptor(),
]);
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return _dio.post(path, data: jsonEncode(data));
  }

  Future<Response> get(String path, ) async {
    return _dio.get(path);
  }

  Future<Response> fetch(RequestOptions options) async {
    return _dio.fetch(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}

class AuthenticatedInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    final accessToken = SharedPrefService.instance.getValue("token");
    print("onRequest ${options.uri} ${accessToken}");

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer ${accessToken}";
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    print("onResponse status: ${response.statusCode}");

    if (response.statusCode == 401 && !response.requestOptions.uri.pathSegments.contains("refresh")) {
      final accessToken = SharedPrefService.instance.getValue("token");
      final refreshToken = SharedPrefService.instance.getValue("refresh_token");

      await SharedPrefService.instance.remove("token");
      if (refreshToken != null) {
        final refreshResponse = await ApiService.instance.post("/token/refresh", {"refresh_token": refreshToken});
        print("refreshResponse status: ${refreshResponse.statusCode}");
        if (refreshResponse.statusCode == 401) {
          // refresh token is invalid
          await SharedPrefService.instance.remove("refresh_token");
        } else {
          final payload = refreshResponse.data;
          final accessToken = payload["token"];
          await SharedPrefService.instance.setValue("token", accessToken);
          response.requestOptions.headers["Authorization"] = "Bearer ${accessToken}";
          final newResponse = await ApiService.instance.fetch(response.requestOptions);
          handler.resolve(newResponse);
        }
      }
    }
    super.onResponse(response, handler);
  }
}