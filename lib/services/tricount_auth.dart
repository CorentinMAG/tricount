import 'package:localstorage/localstorage.dart';

class TricountAuth {
  TricountAuth._();
  static final TricountAuth _instance = TricountAuth._();

  bool _initialized = false;
  late LocalStorage _localStorage;

  LocalStorage get localStorage => _localStorage;
  Future<bool> get hasAccessToken => _localStorage.getItem("access_token")!;
  Future<String?> get accessToken => _localStorage.getItem("access_token");
  
}