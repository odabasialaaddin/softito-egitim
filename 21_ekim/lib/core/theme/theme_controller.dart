import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._internal();
  static final ThemeController instance = ThemeController._internal();

  final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    if (themeMode.value != mode) {
      themeMode.value = mode;
    }
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.dark;
    }
  }

  void dispose() {
    themeMode.dispose();
  }
}
