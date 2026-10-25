import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth_register/view/auth_register_view.dart';

/// [ÜST AÇIKLAMA]: main fonksiyonu, Flutter motorunun başlatılmasını tetikler
/// ve uygulama durumunu ayağa kaldıran KiralaApp ana widget'ını başlatır.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = ThemeController();
  runApp(KiralaApp(themeController: themeController));
}
// [ALT AÇIKLAMA]: WidgetsFlutterBinding.ensureInitialized() ile yerel kanallar hazırlandıktan sonra
// bağımsız ThemeController oluşturularak KiralaApp'e iletilir.

/// [ÜST AÇIKLAMA]: KiralaApp, Material 3 standartlarında çift tema (Aydınlık / Karanlık / Sistem)
/// desteğini ValueListenableBuilder ile reaktif olarak dinleyen kök widget'tır.
/// 40 satır build sınırına uygundur.
class KiralaApp extends StatelessWidget {
  final ThemeController themeController;

  const KiralaApp({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController.themeModeNotifier,
      builder: (context, currentThemeMode, _) {
        return MaterialApp(
          title: 'Kirala',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentThemeMode,
          home: AuthRegisterView(themeController: themeController),
        );
      },
    );
  }
}
// [ALT AÇIKLAMA]: MaterialApp seviyesinde themeMode'un reaktif dinlenmesi sayesinde,
// kullanıcı veya sistem temayı değiştirdiğinde tüm ekranlar anında uyum sağlar.
