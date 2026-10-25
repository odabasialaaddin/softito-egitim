import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/view/login_view.dart';
import 'features/schedule/view/schedule_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeMode,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          home: ValueListenableBuilder(
            valueListenable: AuthController.instance.currentUser,
            builder: (context, user, _) {
              return user != null
                  ? const ScheduleView()
                  : const LoginView();
            },
          ),
        );
      },
    );
  }
}
