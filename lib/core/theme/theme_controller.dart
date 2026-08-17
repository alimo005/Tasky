import 'package:flutter/material.dart';
import '../constants/storge_key.dart';
import '../services/sharedpreferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  void init() {
    bool result = SharedPreferencesManager().getBool(StorgeKey.theme) ?? false;

    themeNotifier.value = result
        ? themeNotifier.value = ThemeMode.dark
        : themeNotifier.value = ThemeMode.light;
  }

  void switchTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await SharedPreferencesManager().setBool(StorgeKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await SharedPreferencesManager().setBool(StorgeKey.theme, true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
  static bool isLight() => themeNotifier.value == ThemeMode.light;
}
