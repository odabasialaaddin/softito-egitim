import 'package:flutter/foundation.dart';
import '../../../core/constants/app_strings.dart';
import '../models/user_model.dart';

class AuthController {
  AuthController._internal();
  static final AuthController instance = AuthController._internal();

  final ValueNotifier<UserRole> selectedRole =
      ValueNotifier<UserRole>(UserRole.student);

  final ValueNotifier<UserModel?> currentUser =
      ValueNotifier<UserModel?>(null);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  void setRole(UserRole role) {
    selectedRole.value = role;
  }

  bool login(String usernameOrId, String password) {
    errorMessage.value = null;
    final trimmedId = usernameOrId.trim();
    final trimmedPass = password.trim();

    if (trimmedId.isEmpty || trimmedPass.isEmpty) {
      errorMessage.value = AppStrings.pleaseFillAllFields;
      return false;
    }

    // Varsayılan giriş: id: user, şifre: 123456
    if (trimmedId == AppStrings.defaultUserId &&
        trimmedPass == AppStrings.defaultUserPassword) {
      currentUser.value = UserModel(
        id: trimmedId,
        name: selectedRole.value.isTeacher ? 'Ahmet Öğretmen' : 'Ali Öğrenci',
        email: '$trimmedId@okul.k12.tr',
        role: selectedRole.value,
      );
      return true;
    }

    errorMessage.value = AppStrings.invalidCredentials;
    return false;
  }

  bool register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    required UserRole role,
  }) {
    errorMessage.value = null;

    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty ||
        passwordConfirm.trim().isEmpty) {
      errorMessage.value = AppStrings.pleaseFillAllFields;
      return false;
    }

    if (password != passwordConfirm) {
      errorMessage.value = AppStrings.passwordsDoNotMatch;
      return false;
    }

    currentUser.value = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: email.trim(),
      role: role,
    );
    return true;
  }

  String forgotPassword(String email) {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      return AppStrings.pleaseFillAllFields;
    }
    return AppStrings.forgotPasswordSent(trimmedEmail);
  }

  void logout() {
    currentUser.value = null;
    errorMessage.value = null;
  }

  void dispose() {
    selectedRole.dispose();
    currentUser.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
