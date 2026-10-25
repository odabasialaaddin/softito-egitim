import 'package:flutter/material.dart';

import '../models/auth_register_model.dart';

/// [ÜST AÇIKLAMA]: AuthRegisterController, kayıt formunun durumunu (state),
/// veri kontrolcülerini (TextEditingController) ve sıkı iş kuralı validasyonlarını
/// UI katmanından bağımsız olarak yöneten sınıftır.
/// Reaktif kontroller ValueNotifier ile sağlanır.
class AuthRegisterController {
  /// Formun doğrulama durumunu yöneten GlobalKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Ad Soyad metin giriş kontrolcüsü
  final TextEditingController nameController = TextEditingController();

  /// TC Kimlik / Pasaport No metin giriş kontrolcüsü
  final TextEditingController idController = TextEditingController();

  /// Telefon numarası metin giriş kontrolcüsü
  final TextEditingController phoneController = TextEditingController();

  /// Seçili cinsiyeti tutan reaktif ValueNotifier
  final ValueNotifier<String?> genderNotifier = ValueNotifier<String?>(null);

  /// Başarıyla kaydedilen kullanıcı bilgisini tutan reaktif notifier
  final ValueNotifier<UserRegisterModel?> registeredUserNotifier =
      ValueNotifier<UserRegisterModel?>(null);

  /// Cinsiyet seçenekleri listesi
  static const List<String> genderOptions = [
    'Erkek',
    'Kadın',
    'Belirtmek İstemiyorum',
  ];

  /// [ÜST AÇIKLAMA]: Ad Soyad alanının boş bırakılmamasını ve en az 3 karakter olmasını denetler.
  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ad Soyad alanı boş bırakılamaz.';
    }
    if (value.trim().length < 3) {
      return 'Ad Soyad en az 3 karakter olmalıdır.';
    }
    return null;
  }
  // [ALT AÇIKLAMA]: Geçerli bir isim girişi sağlandığında null dönerek formun onaylanmasına izin verir.

  /// [ÜST AÇIKLAMA]: TC Kimlik veya Pasaport numarasının tam 11 haneli rakamlardan oluştuğunu doğrular.
  String? validateIdentityNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'TC Kimlik / Pasaport No boş bırakılamaz.';
    }
    final cleanValue = value.trim();
    final tcRegex = RegExp(r'^\d{11}$');
    if (!tcRegex.hasMatch(cleanValue)) {
      return 'TC / Pasaport No tam 11 haneli rakamlardan oluşmalıdır.';
    }
    return null;
  }
  // [ALT AÇIKLAMA]: Düzenli ifade (RegExp) ile harf veya eksik/fazla basamak girişleri engellenir.

  /// [ÜST AÇIKLAMA]: Telefon numarasının Türkiye formatında (başında 0 olmadan) tam 10 haneli
  /// ve 5 ile başlayan rakamlar olduğunu doğrular (Örn: 5XXXXXXXXX).
  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telefon numarası boş bırakılamaz.';
    }
    final cleanValue = value.trim();
    final phoneRegex = RegExp(r'^5\d{9}$');
    if (!phoneRegex.hasMatch(cleanValue)) {
      return 'Telefon 5 ile başlayan 10 haneli rakam olmalıdır (Örn: 5551234567).';
    }
    return null;
  }
  // [ALT AÇIKLAMA]: 10 haneli geçerli GSM formatı sağlanmadıkça kullanıcıya net yönlendirici hata mesajı gösterilir.

  /// [ÜST AÇIKLAMA]: Cinsiyet seçiminin yapılıp yapılmadığını denetler.
  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir cinsiyet seçiniz.';
    }
    return null;
  }
  // [ALT AÇIKLAMA]: Dropdown menüden bir seçenek seçilmediğinde formun geçmesini engeller.

  /// [ÜST AÇIKLAMA]: Formu doğrular, geçerliyse UserRegisterModel nesnesini üretip registeredUserNotifier'a yazar.
  bool submitForm() {
    final formState = formKey.currentState;
    if (formState == null) return false;

    if (formState.validate()) {
      final user = UserRegisterModel(
        fullName: nameController.text.trim(),
        identityNumber: idController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        gender: genderNotifier.value ?? '',
      );
      registeredUserNotifier.value = user;
      return true;
    }
    return false;
  }
  // [ALT AÇIKLAMA]: Form validasyonu başarılıysa true, herhangi bir alan hatalıysa false döndürür.

  /// [ÜST AÇIKLAMA]: Formdaki tüm alanları temizleyip başlangıç durumuna döndürür.
  void resetForm() {
    formKey.currentState?.reset();
    nameController.clear();
    idController.clear();
    phoneController.clear();
    genderNotifier.value = null;
    registeredUserNotifier.value = null;
  }
  // [ALT AÇIKLAMA]: Formun ve controller'ların durumunu güvenle sıfırlar.

  /// [ÜST AÇIKLAMA]: Ekran kapandığında hafıza sızıntılarını önlemek için tüm denetleyicileri yok eder.
  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
    genderNotifier.dispose();
    registeredUserNotifier.dispose();
  }
  // [ALT AÇIKLAMA]: Controller lifecycle yönetimi kapsamında dispose işlemi eksiksiz tamamlanır.
}
// [ALT AÇIKLAMA]: AuthRegisterController, iş mantığını ve validasyonları UI'dan ayırarak
// kodun birim testlerle (unit test) kolayca sınanmasını sağlar.
