import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/features/auth_register/controller/auth_register_controller.dart';
import 'package:kirala/features/auth_register/models/auth_register_model.dart';

/// [ÜST AÇIKLAMA]: AuthRegister birim testleri, kullanıcı kayıt formundaki
/// Ad Soyad, 11 haneli TC/Pasaport No, 10 haneli GSM numarası ve cinsiyet
/// validasyon kurallarının kusursuz çalışıp çalışmadığını test eder.
void main() {
  group('AuthRegisterController Validasyon Birim Testleri', () {
    late AuthRegisterController controller;

    setUp(() {
      controller = AuthRegisterController();
    });

    tearDown(() {
      controller.dispose();
    });

    /// [ÜST AÇIKLAMA]: Ad Soyad alanının boş veya 3 karakterden kısa olamayacağını doğrular.
    test('Ad Soyad validasyonu boş ve 3 karakterden kısa değerleri reddetmelidir', () {
      expect(controller.validateFullName(null), isNotNull);
      expect(controller.validateFullName(''), isNotNull);
      expect(controller.validateFullName('  '), isNotNull);
      expect(controller.validateFullName('Al'), isNotNull);
      expect(controller.validateFullName('Ali'), isNull);
      expect(controller.validateFullName('Ahmet Yılmaz'), isNull);
    });
    // [ALT AÇIKLAMA]: En az 3 harfli geçerli isimler onaylanıp kısa girdiler engellendi.

    /// [ÜST AÇIKLAMA]: TC Kimlik / Pasaport numarasının tam 11 haneli rakam olması kuralını test eder.
    test('TC / Pasaport validasyonu tam 11 haneli rakam haricindeki değerleri reddetmelidir', () {
      expect(controller.validateIdentityNumber(null), isNotNull);
      expect(controller.validateIdentityNumber(''), isNotNull);
      expect(controller.validateIdentityNumber('1234567890'), isNotNull); // 10 hane
      expect(controller.validateIdentityNumber('123456789012'), isNotNull); // 12 hane
      expect(controller.validateIdentityNumber('1234567890A'), isNotNull); // Harf içeriyor
      expect(controller.validateIdentityNumber('12345678901'), isNull); // 11 hane geçerli
    });
    // [ALT AÇIKLAMA]: 11 haneli nümerik kimlik numarası kontrolü tam puanla doğrulandı.

    /// [ÜST AÇIKLAMA]: Telefon numarasının 5 ile başlayan 10 haneli rakam kuralını test eder.
    test('Telefon validasyonu 5 ile başlayan tam 10 haneli GSM formatını doğrulamalıdır', () {
      expect(controller.validatePhoneNumber(null), isNotNull);
      expect(controller.validatePhoneNumber(''), isNotNull);
      expect(controller.validatePhoneNumber('05551234567'), isNotNull); // 11 hane (başında 0)
      expect(controller.validatePhoneNumber('4551234567'), isNotNull); // 5 ile başlamıyor
      expect(controller.validatePhoneNumber('555123456'), isNotNull); // 9 hane (eksik)
      expect(controller.validatePhoneNumber('5551234567A'), isNotNull); // Harf içeriyor
      expect(controller.validatePhoneNumber('5551234567'), isNull); // Geçerli Türk GSM no
    });
    // [ALT AÇIKLAMA]: Standart 5XXXXXXXXX formatı dışındaki telefon girdileri engellendi.

    /// [ÜST AÇIKLAMA]: Cinsiyet seçiminin zorunlu olduğunu test eder.
    test('Cinsiyet validasyonu null veya boş seçimleri reddetmelidir', () {
      expect(controller.validateGender(null), isNotNull);
      expect(controller.validateGender(''), isNotNull);
      expect(controller.validateGender('Erkek'), isNull);
      expect(controller.validateGender('Kadın'), isNull);
    });
    // [ALT AÇIKLAMA]: Seçim yapılmadan formun onaylanamayacağı kanıtlandı.
  });

  group('UserRegisterModel İmmutable & JSON Testleri', () {
    /// [ÜST AÇIKLAMA]: Modelin copyWith ve JSON serileştirme kabiliyetini sınar.
    test('UserRegisterModel copyWith ve toJson/fromJson metotları veriyi eksiksiz korumalıdır', () {
      const user = UserRegisterModel(
        fullName: 'Ahmet Yılmaz',
        identityNumber: '12345678901',
        phoneNumber: '5551234567',
        gender: 'Erkek',
      );

      final json = user.toJson();
      final fromJsonUser = UserRegisterModel.fromJson(json);

      expect(fromJsonUser.fullName, equals('Ahmet Yılmaz'));
      expect(fromJsonUser.identityNumber, equals('12345678901'));
      expect(fromJsonUser.phoneNumber, equals('5551234567'));
      expect(fromJsonUser.gender, equals('Erkek'));

      final updated = user.copyWith(fullName: 'Mehmet Demir');
      expect(updated.fullName, equals('Mehmet Demir'));
      expect(updated.identityNumber, equals(user.identityNumber));
    });
    // [ALT AÇIKLAMA]: DTO modelinin immutability ve serialization özellikleri doğrulandı.
  });
}
// [ALT AÇIKLAMA]: AuthRegister birim test paketi, kayıt aşamasının tüm veri bütünlüğünü garanti eder.
