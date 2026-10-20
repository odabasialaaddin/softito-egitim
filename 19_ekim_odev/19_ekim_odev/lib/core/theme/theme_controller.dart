import 'package:flutter/material.dart';

/// CanVer uygulamasının tema durumunu yöneten reaktif kontrolcü.
///
/// Harici state paketi kullanmadan [ValueNotifier] ile ThemeMode.system,
/// ThemeMode.dark ve ThemeMode.light modları arasında geçiş sağlar.
class ThemeController {
  // Singleton deseni
  ThemeController._internal();
  static final ThemeController instance = ThemeController._internal();

  /// Aktif tema modunu dinleyen reaktif bildirimci
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  /// Aktif tema modu
  ThemeMode get currentThemeMode => themeModeNotifier.value;

  /// Temayı doğrudan belirtilen moda ayarlar
  void setThemeMode(ThemeMode mode) {
    if (themeModeNotifier.value != mode) {
      themeModeNotifier.value = mode;
    }
  }

  /// Sırasıyla sistem -> karanlık -> aydınlık modları arasında döner
  void toggleTheme() {
    switch (themeModeNotifier.value) {
      case ThemeMode.system:
        themeModeNotifier.value = ThemeMode.dark;
      case ThemeMode.dark:
        themeModeNotifier.value = ThemeMode.light;
      case ThemeMode.light:
        themeModeNotifier.value = ThemeMode.system;
    }
  }

  /// Karanlık mod zorlanmış mı veya sistem teması ile birlikte karanlık mı kontrol eder
  bool isDarkActive(BuildContext context) {
    if (themeModeNotifier.value == ThemeMode.dark) return true;
    if (themeModeNotifier.value == ThemeMode.light) return false;
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  /// Bellek sızıntısını önlemek için dinleyiciyi kapatır
  void dispose() {
    themeModeNotifier.dispose();
  }
}
