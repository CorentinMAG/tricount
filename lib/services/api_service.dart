import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tricount/services/shared_preferences_service.dart';
import 'package:tricount/utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._();
  late Dio _dio;

  ApiService._();

  static ApiService get instance => _instance;

  factory ApiService() {
    return _instance;
  }

  Future<void> initialize() async {
    final options = BaseOptions(
      baseUrl: Environment.baseApi.toString(),
      connectTimeout: const Duration(seconds: 5),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      validateStatus: (int? status) {
        return status != null;
      }
    );
    _dio = Dio(options);
    _dio.interceptors.add(AuthenticationInterceptor());
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return _dio.post(path, data: jsonEncode(data));
  }

  Future<Response> get(String path, [Map<String, dynamic>? params]) async {
    if (params == null) {
      return _dio.get(path);
    }
    return _dio.get(path, data: params);
  }

  Future<Response> fetch(RequestOptions options) async {
    return _dio.fetch(options);
  }
}

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    final token = SharedPrefService.instance.getValue('token');

    if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.requestOptions.headers.containsKey('Authorization')) {
      await _refreshToken();
      err.requestOptions.headers['Authorization'] = 'Bearer ${SharedPrefService.instance.getValue('token')}';
      handler.resolve(await ApiService.instance.fetch(err.requestOptions));
    }
    super.onError(err, handler);
  }

  Future<void> _refreshToken() async {
    final Response response = await ApiService.instance.get("/token/refresh");
    if (response.statusCode == 200) {
      final Map<String, String> credentials  = response.data;
      final token = credentials['token']!;
      final refreshToken = credentials['refresh_token']!;

      SharedPrefService.instance.setValue('token', token);
      SharedPrefService.instance.setValue('refresh_token', refreshToken);
    }
  }
}