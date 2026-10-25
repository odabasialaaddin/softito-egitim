import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widget/app_gradient_button.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.forgotPasswordTitle)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.mark_email_read_outlined,
                        size: 56,
                        color: AppColors.earthDark,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Hesabınıza bağlı e-posta adresinizi giriniz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textDark, fontSize: 14),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: AppStrings.email,
                          prefixIcon: Icon(Icons.email, color: AppColors.earthDark),
                        ),
                      ),
                      const SizedBox(height: 18),
                      AppGradientButton(
                        onPressed: _handleSendReset,
                        child: const Text(AppStrings.sendResetEmail),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSendReset() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      context.showSnackBar(AppStrings.pleaseFillAllFields, isError: true);
      return;
    }

    final message = AuthController.instance.forgotPassword(email);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bilgilendirme'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }
}
