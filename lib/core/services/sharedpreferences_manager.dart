import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  // Create private Constructor
  SharedPreferencesManager._internal();

  // Create private instance to store private Constructor SharedPreferencesManager._internal();
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  // Create Factory constructor to return private _instance

  factory SharedPreferencesManager() {
    return _instance;
  }

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  clear() async {
    return await _preferences.clear();
  }

  remove(String key) async {
    return await _preferences.remove(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }
}
