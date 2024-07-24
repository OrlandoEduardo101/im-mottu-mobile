import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesService {
  Future<void> saveCacheMap({required String key, required Map<String, dynamic> data});
  Future<Map<String, dynamic>> readCacheMap({required String key});
  Future<String?> readString({required String key});
  Future<void> setString({required String key, required String value});
  Future<void> cleanCache();
}

class SharedPreferencesService implements ISharedPreferencesService {
  @override
  Future<void> setString({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> readString({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<Map<String, dynamic>> readCacheMap({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return jsonDecode(data ?? '{}');
  }

  @override
  Future<void> saveCacheMap({required String key, required Map<String, dynamic> data}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  @override
  Future<void> cleanCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
