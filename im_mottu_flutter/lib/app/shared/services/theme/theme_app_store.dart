import 'package:flutter/material.dart';

import '../local_storage/preferences_key_strings.dart';
import '../local_storage/shared_preferences_service.dart';
import 'theme_app_state.dart';

class ThemeAppStore extends ValueNotifier<ThemeAppState> {
  final ISharedPreferencesService prefs;

  ThemeAppStore(this.prefs) : super(ThemeAppState.initState());

  Future<void> getThemeApp() async {
    final themePrefs = await prefs.readString(key: kThemePrefsKey);
    ThemeEnum theme;

    themePrefs == ThemeEnum.darkTheme.name ? theme = ThemeEnum.darkTheme : theme = ThemeEnum.lightTheme;

    changeTheme(theme);
  }

  void changeTheme(ThemeEnum theme) {
    value = ThemeAppState(theme: theme);
    prefs.setString(key: kThemePrefsKey, value: theme.name);
  }

  Future<void> clearCache() async {
    await prefs.cleanCache();
  }
}
