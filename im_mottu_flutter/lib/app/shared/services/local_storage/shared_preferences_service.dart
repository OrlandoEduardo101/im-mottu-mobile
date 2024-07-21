import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_app_state.dart';
import 'preferences_key_strings.dart';

abstract class ISharedPreferencesService {
  Future<void> saveCacheMap({required String key, required Map<String, dynamic> data});
  Future<Map<String, dynamic>> readCacheMap({required String key});
  Future<void> saveThemeApp({required ThemeEnum theme});
  Future<String?> getThemeApp();
}

class SharedPreferencesService implements ISharedPreferencesService {
  @override
  Future<void> saveThemeApp({required ThemeEnum theme}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kThemePrefsKey, theme.name);
  }

  @override
  Future<String?> getThemeApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kThemePrefsKey);
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
}
