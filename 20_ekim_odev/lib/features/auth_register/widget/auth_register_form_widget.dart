import 'package:flutter/material.dart';
import '../controller/auth_register_controller.dart';

/// [ÜST AÇIKLAMA]: AuthRegisterFormWidget, kullanıcı kayıt formunun giriş alanlarını
/// (Ad Soyad, TC No, Telefon, Cinsiyet) ve onay butonlarını barındıran modüler bileşendir.
/// 40 satır build sınırı gözetilerek alt parçalar özel metotlara/bileşenlere bölünmüştür.
class AuthRegisterFormWidget extends StatelessWidget {
  final AuthRegisterController controller;
  final VoidCallback onSubmitted;

  const AuthRegisterFormWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  /// [ÜST AÇIKLAMA]: Ad Soyad giriş alanı widget'ı
  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      key: const Key('name_input_field'),
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Ad Soyad',
        hintText: 'Örn: Ahmet Yılmaz',
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: controller.validateFullName,
    );
  }
  // [ALT AÇIKLAMA]: Ad Soyad girişi için kullanıcı dostu placeholder ve ikon sağlar.

  /// [ÜST AÇIKLAMA]: TC Kimlik / Pasaport no giriş alanı widget'ı
  Widget _buildIdentityField(BuildContext context) {
    return TextFormField(
      key: const Key('identity_input_field'),
      controller: controller.idController,
      keyboardType: TextInputType.number,
      maxLength: 11,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'TC Kimlik / Pasaport No',
        hintText: '11 haneli kimlik numaranız',
        prefixIcon: Icon(Icons.badge_outlined),
        counterText: '',
      ),
      validator: controller.validateIdentityNumber,
    );
  }
  // [ALT AÇIKLAMA]: Sadece 11 haneli rakam kabul eden ve sayaç kalabalığını gizleyen kimlik alanı.

  /// [ÜST AÇIKLAMA]: GSM telefon numarası giriş alanı widget'ı
  Widget _buildPhoneField(BuildContext context) {
    return TextFormField(
      key: const Key('phone_input_field'),
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Cep Telefonu',
        hintText: '5XXXXXXXXX',
        prefixIcon: Icon(Icons.phone_android_outlined),
        prefixText: '+90 ',
        counterText: '',
      ),
      validator: controller.validatePhoneNumber,
    );
  }
  // [ALT AÇIKLAMA]: +90 ön eki ile 10 haneli standart telefon numarası formatı sunar.

  /// [ÜST AÇIKLAMA]: Cinsiyet açılır menüsü (DropdownButtonFormField) widget'ı
  Widget _buildGenderDropdown(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller.genderNotifier,
      builder: (context, selectedGender, _) {
        return DropdownButtonFormField<String>(
          key: ValueKey('gender_$selectedGender'),
          initialValue: selectedGender,
          decoration: const InputDecoration(
            labelText: 'Cinsiyet',
            prefixIcon: Icon(Icons.wc_outlined),
          ),
          items: AuthRegisterController.genderOptions.map((gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: (value) => controller.genderNotifier.value = value,
          validator: controller.validateGender,
        );
      },
    );
  }
  // [ALT AÇIKLAMA]: ValueListenableBuilder ile reaktif olarak güncellenen cinsiyet dropdown seçicisi.

  /// [ÜST AÇIKLAMA]: Kaydol ve Temizle butonlarını içeren aksiyon satırı
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton(
            key: const Key('reset_form_button'),
            onPressed: controller.resetForm,
            child: const Text('Temizle'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: FilledButton.icon(
            key: const Key('submit_register_button'),
            onPressed: onSubmitted,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Kaydol'),
          ),
        ),
      ],
    );
  }
  // [ALT AÇIKLAMA]: Temizleme ve onaylama işlevlerini görsel hiyerarşiyle sunan buton grubu.

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNameField(context),
          const SizedBox(height: 16),
          _buildIdentityField(context),
          const SizedBox(height: 16),
          _buildPhoneField(context),
          const SizedBox(height: 16),
          _buildGenderDropdown(context),
          const SizedBox(height: 24),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
// [ALT AÇIKLAMA]: AuthRegisterFormWidget, Form State'i tek bir yerde toplayıp
// controller üzerindeki validasyon metotlarını kusursuz şekilde tetikler.
