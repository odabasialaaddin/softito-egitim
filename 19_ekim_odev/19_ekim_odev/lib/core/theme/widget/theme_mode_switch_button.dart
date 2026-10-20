import 'package:flutter/material.dart';
import '../theme_controller.dart';

/// Tema modunu (Sistem / Karanlık / Aydınlık) reaktif olarak değiştiren buton.
class ThemeModeSwitchButton extends StatelessWidget {
  const ThemeModeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeModeNotifier,
      builder: (context, themeMode, _) {
        return IconButton(
          tooltip: _getTooltip(themeMode),
          onPressed: ThemeController.instance.toggleTheme,
          icon: _ThemeAnimatedIcon(themeMode: themeMode),
        );
      },
    );
  }

  String _getTooltip(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Tema: Sistem (Karanlık moda geç)';
      case ThemeMode.dark:
        return 'Tema: Karanlık Gece (Aydınlık moda geç)';
      case ThemeMode.light:
        return 'Tema: Aydınlık Medikal (Sistem moduna geç)';
    }
  }
}

class _ThemeAnimatedIcon extends StatelessWidget {
  final ThemeMode themeMode;

  const _ThemeAnimatedIcon({required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final IconData iconData = switch (themeMode) {
      ThemeMode.system => Icons.brightness_auto_rounded,
      ThemeMode.dark => Icons.dark_mode_rounded,
      ThemeMode.light => Icons.light_mode_rounded,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Icon(
        iconData,
        key: ValueKey<ThemeMode>(themeMode),
        size: 22,
      ),
    );
  }
}
