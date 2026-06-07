import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    await _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance.getBool(key) ?? true;
  }

  static Future<void> setInt(String key, int value) async {
    await _instance.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _instance.getInt(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String getString(String key) {
    return _instance.getString(key) ?? '';
  }

  static Future<void> setIntList(String key, List<int> value) async {
    await _instance.setStringList(
      key,
      value.map((e) => e.toString()).toList(),
    );
  }

  static List<int> getIntList(String key) {
    return (_instance.getStringList(key) ?? [])
        .map(int.parse)
        .toList();
  }

  static Future<void> delete(String key) async {
    await _instance.remove(key);
  }

  static Future<void> clear() async {
    await _instance.clear();
  }

  static Future<void> put(String weekAnchorKey, String anchor) async {
    await _instance.setString(weekAnchorKey, anchor);
  }
}