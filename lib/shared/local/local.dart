import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences.setString(key, value);
  }

  static getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool?> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
