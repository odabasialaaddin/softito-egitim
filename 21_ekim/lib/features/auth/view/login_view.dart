import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_gradient_button.dart';
import '../controller/auth_controller.dart';
import '../models/user_model.dart';
import '../widget/ataturk_quote_banner.dart';
import '../widget/role_selector_dropdown.dart';
import 'register_view.dart';
import 'forgot_password_view.dart';
import '../../schedule/view/schedule_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: AppStrings.defaultUserId);
    _passwordController =
        TextEditingController(text: AppStrings.defaultUserPassword);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: const [ThemeModeSwitchButton()],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AtaturkQuoteBanner(),
                  const SizedBox(height: 24),
                  _buildFormCard(context),
                  const SizedBox(height: 16),
                  _buildFooterLinks(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.loginTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<UserRole>(
              valueListenable: AuthController.instance.selectedRole,
              builder: (context, role, _) => RoleSelectorDropdown(
                selectedRole: role,
                onChanged: (newRole) {
                  if (newRole != null) {
                    AuthController.instance.setRole(newRole);
                  }
                },
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: AppStrings.usernameOrId,
                prefixIcon: Icon(Icons.person, color: AppColors.earthDark),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.password,
                prefixIcon: Icon(Icons.lock, color: AppColors.earthDark),
              ),
            ),
            const SizedBox(height: 12),
            _buildErrorMessage(),
            const SizedBox(height: 8),
            AppGradientButton(
              onPressed: _handleLogin,
              child: const Text(AppStrings.loginTitle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return ValueListenableBuilder<String?>(
      valueListenable: AuthController.instance.errorMessage,
      builder: (context, err, _) {
        if (err == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            err,
            style: const TextStyle(
              color: AppColors.error,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const ForgotPasswordView(),
            ),
          ),
          child: const Text(
            AppStrings.forgotPasswordTitle,
            style: TextStyle(color: AppColors.textDark),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const RegisterView(),
            ),
          ),
          child: const Text(
            AppStrings.registerTitle,
            style: TextStyle(
              color: AppColors.grassGreenDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    final success = AuthController.instance.login(
      _idController.text,
      _passwordController.text,
    );
    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const ScheduleView()),
      );
    }
  }
}
