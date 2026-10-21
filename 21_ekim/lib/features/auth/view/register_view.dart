import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widget/app_gradient_button.dart';
import '../controller/auth_controller.dart';
import '../models/user_model.dart';
import '../widget/role_selector_dropdown.dart';
import '../../schedule/view/schedule_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  UserRole _selectedRole = UserRole.student;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.registerTitle)),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoleSelectorDropdown(
                        selectedRole: _selectedRole,
                        onChanged: (role) {
                          if (role != null) setState(() => _selectedRole = role);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildTextFields(),
                      const SizedBox(height: 16),
                      AppGradientButton(
                        onPressed: _handleRegister,
                        child: const Text(AppStrings.registerTitle),
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

  Widget _buildTextFields() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: AppStrings.fullName,
            prefixIcon: Icon(Icons.person, color: AppColors.earthDark),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: AppStrings.email,
            prefixIcon: Icon(Icons.email, color: AppColors.earthDark),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: AppStrings.password,
            prefixIcon: Icon(Icons.lock, color: AppColors.earthDark),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _confirmController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: AppStrings.passwordConfirm,
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.earthDark),
          ),
        ),
      ],
    );
  }

  void _handleRegister() {
    final success = AuthController.instance.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirm: _confirmController.text,
      role: _selectedRole,
    );

    if (success && mounted) {
      context.showSnackBar(AppStrings.tempSavedMessage);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const ScheduleView()),
        (route) => false,
      );
    } else if (mounted && AuthController.instance.errorMessage.value != null) {
      context.showSnackBar(
        AuthController.instance.errorMessage.value!,
        isError: true,
      );
    }
  }
}
