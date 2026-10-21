import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../theme_controller.dart';

class ThemeModeSwitchButton extends StatelessWidget {
  const ThemeModeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeMode,
      builder: (context, currentMode, _) {
        final icon = _resolveIcon(currentMode);
        return IconButton(
          tooltip: 'Tema Değiştir',
          icon: Icon(icon, color: AppColors.white),
          onPressed: () => _showThemeSelectionDialog(context, currentMode),
        );
      },
    );
  }

  IconData _resolveIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  void _showThemeSelectionDialog(BuildContext context, ThemeMode currentMode) {
    showDialog<void>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Tema Seçimi'),
        children: [
          _buildOption(
            ctx,
            title: 'Sistem Teması',
            icon: Icons.brightness_auto,
            mode: ThemeMode.system,
            isSelected: currentMode == ThemeMode.system,
          ),
          _buildOption(
            ctx,
            title: 'Aydınlık Mod',
            icon: Icons.light_mode,
            mode: ThemeMode.light,
            isSelected: currentMode == ThemeMode.light,
          ),
          _buildOption(
            ctx,
            title: 'Karanlık Mod',
            icon: Icons.dark_mode,
            mode: ThemeMode.dark,
            isSelected: currentMode == ThemeMode.dark,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode mode,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.grassGreenDark : AppColors.textDark,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.grassGreenDark : AppColors.textDark,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.grassGreen)
          : null,
      onTap: () {
        ThemeController.instance.setThemeMode(mode);
        Navigator.of(context).pop();
      },
    );
  }
}
