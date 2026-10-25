import 'package:flutter_test/flutter_test.dart';
import 'package:ders_programi_duzenleyici/features/auth/controller/auth_controller.dart';
import 'package:ders_programi_duzenleyici/features/auth/models/user_model.dart';

void main() {
  group('AuthController Tests', () {
    final controller = AuthController.instance;

    test('Login with default credentials (user/123456) succeeds', () {
      controller.setRole(UserRole.teacher);
      final loggedIn = controller.login('user', '123456');

      expect(loggedIn, isTrue);
      expect(controller.currentUser.value, isNotNull);
      expect(controller.currentUser.value!.role, equals(UserRole.teacher));
    });

    test('Login with wrong credentials fails', () {
      final loggedIn = controller.login('user', 'wrongpass');
      expect(loggedIn, isFalse);
      expect(controller.errorMessage.value, isNotNull);
    });

    test('Forgot password generates recovery message', () {
      final message = controller.forgotPassword('ogrenci@okul.k12.tr');
      expect(message, contains('ogrenci@okul.k12.tr'));
      expect(message, contains('kurtarma e-postası gönderildi'));
    });
  });
}
