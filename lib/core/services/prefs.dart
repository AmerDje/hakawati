import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static SharedPreferences? _prefs;

  // Asynchronously get the SharedPreferences instance
  static Future<SharedPreferences> get _instance async => _prefs ??= await SharedPreferences.getInstance();

  // Initialize prefs - should be called once (e.g., in the initState() of your main app widget)
  static Future<void> init() async {
    _prefs = await _instance;
  }

  // Sets a boolean value
  static Future<bool> setBool(String key, bool value) async {
    final prefs = await _instance; // ensure prefs is initialized
    return prefs.setBool(key, value);
  }

  // Sets a double value
  static Future<bool> setDouble(String key, double value) async {
    final prefs = await _instance;
    return prefs.setDouble(key, value);
  }

  // Sets an integer value
  static Future<bool> setInt(String key, int value) async {
    final prefs = await _instance;
    return prefs.setInt(key, value);
  }

  // Sets a string value
  static Future<bool> setString(String key, String value) async {
    final prefs = await _instance;
    return prefs.setString(key, value);
  }

  // Sets a list of strings
  static Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  // Gets a boolean value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Gets a double value
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // Gets an integer value
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Gets a string value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Gets a list of strings
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  // Removes a key
  static Future<bool> remove(String key) async {
    final prefs = await _instance;
    return prefs.remove(key);
  }

  // Clears all data
  static Future<bool> clear() async {
    final prefs = await _instance;
    return prefs.clear();
  }
}
