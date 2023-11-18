import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService instance = SharedPrefService._internal();

  SharedPrefService._internal();

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();  
  }

  String? getValue(String name) => _prefs.getString(name);

  Future<void> setValue(String key, String value) async =>  await _prefs.setString(key, value);

  Future<void> remove(String name) async => await _prefs.remove(name);
}