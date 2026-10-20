/// [ÜST AÇIKLAMA]: UserRegisterModel, kullanıcı kayıt formundan toplanan
/// ad soyad, TC/Pasaport no, telefon ve cinsiyet verilerini tutan değişmez (immutable) veri modelidir.
/// Clean Architecture prensiplerine uygun olarak iş mantığı ve UI katmanları arasında veri transfer nesnesi (DTO) olarak kullanılır.
class UserRegisterModel {
  final String fullName;
  final String identityNumber;
  final String phoneNumber;
  final String gender;

  const UserRegisterModel({
    required this.fullName,
    required this.identityNumber,
    required this.phoneNumber,
    required this.gender,
  });

  /// [ÜST AÇIKLAMA]: Mevcut modelin kopyasını alıp yalnızca istenen alanları güncelleyerek
  /// yeni bir nesne türeten copyWith metodu. Değişmezliği (immutability) korur.
  UserRegisterModel copyWith({
    String? fullName,
    String? identityNumber,
    String? phoneNumber,
    String? gender,
  }) {
    return UserRegisterModel(
      fullName: fullName ?? this.fullName,
      identityNumber: identityNumber ?? this.identityNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
    );
  }
  // [ALT AÇIKLAMA]: Null-aware kontrolü ile null gelen alanlar mevcut değerlerini korur.

  /// [ÜST AÇIKLAMA]: JSON (Map) formatındaki veriyi UserRegisterModel nesnesine dönüştüren factory kurucu.
  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      fullName: json['fullName'] as String? ?? '',
      identityNumber: json['identityNumber'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
    );
  }
  // [ALT AÇIKLAMA]: JSON anahtarları okunurken olası null değerlere karşı güvenli varsayılanlar atanır.

  /// [ÜST AÇIKLAMA]: Modeli yerel depolama veya API istekleri için JSON Map formatına çevirir.
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'identityNumber': identityNumber,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
  // [ALT AÇIKLAMA]: Tüm model verileri Map yapısına dönüştürülerek serileştirilebilir hale getirilir.
}
// [ALT AÇIKLAMA]: UserRegisterModel sınıfı değişmez yapısıyla veri güvenliğini garanti altına alır.
