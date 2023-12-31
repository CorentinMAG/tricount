import 'package:localstorage/localstorage.dart';
import 'package:tricount/services/tricount_auth.dart';

class TricountManager {
  static TricountManager get instance => _instance;

  static Future<TricountManager> initialize({
    required String url,
  }) async {
    assert(!_instance._initialized, "This instance is already initialized");
    _instance._init(url);
    final local_storage = LocalStorage('tricount');
    //await TricountAuth.initialize(local_storage);
    return _instance;
  }

  //late TricountClient client;
  bool _initialized = false;

  TricountManager._();
  static final TricountManager _instance = TricountManager._();

  void _init(String url) {
   // client = TricountClient(url);
    _initialized = true;
  }
}