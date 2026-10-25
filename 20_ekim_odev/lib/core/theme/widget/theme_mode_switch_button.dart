import 'package:flutter/material.dart';
import '../theme_controller.dart';

/// [ÜST AÇIKLAMA]: ThemeModeSwitchButton, kullanıcının uygulama temasını
/// (Sistem / Aydınlık / Karanlık) dinamik olarak değiştirmesini sağlayan
/// modüler ve yeniden kullanılabilir bir IconButton bileşenidir.
/// 40 satır kuralına uygun olarak tasarlanmıştır.
class ThemeModeSwitchButton extends StatelessWidget {
  final ThemeController controller;

  const ThemeModeSwitchButton({
    super.key,
    required this.controller,
  });

  /// [ÜST AÇIKLAMA]: Seçili tema moduna göre uygun ikonu belirler.
  IconData _getIconForMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
  // [ALT AÇIKLAMA]: Tema moduna karşılık gelen Material ikonunu döndürür.

  /// [ÜST AÇIKLAMA]: Seçili tema moduna göre açıklayıcı ipucu (tooltip) metnini belirler.
  String _getTooltipForMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Tema: Sistem (Dokunarak Aydınlık moda geç)';
      case ThemeMode.light:
        return 'Tema: Aydınlık (Dokunarak Karanlık moda geç)';
      case ThemeMode.dark:
        return 'Tema: Karanlık (Dokunarak Sistem moduna geç)';
    }
  }
  // [ALT AÇIKLAMA]: Erişilebilirlik ve kullanıcı deneyimi için açıklayıcı ipucu sağlar.

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: controller.themeModeNotifier,
      builder: (context, currentMode, _) {
        return IconButton(
          tooltip: _getTooltipForMode(currentMode),
          icon: Icon(_getIconForMode(currentMode)),
          onPressed: controller.toggleTheme,
        );
      },
    );
  }
}
// [ALT AÇIKLAMA]: ValueListenableBuilder sayesinde sadece butonun ikonu yeniden çizilir,
// tüm sayfanın gereksiz yere rebuild edilmesinin önüne geçilir.
