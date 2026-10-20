import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/home/view/home_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CanVerApp());
}

/// CanVer uygulamasının kök widget'ı.
///
/// Sadece uygulama başlatma ve dinamik tema yapılandırmasını barındırır.
class CanVerApp extends StatelessWidget {
  const CanVerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'CanVer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const HomeScaffold(),
        );
      },
    );
  }
}
