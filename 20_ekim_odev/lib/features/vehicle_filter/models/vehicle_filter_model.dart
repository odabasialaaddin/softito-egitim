/// [ÜST AÇIKLAMA]: VehicleFilterModel, kullanıcının araç kullanım amacı (Şahsi/Ticari)
/// ve sürüş lokasyonu (Şehir İçi/Şehir Dışı) seçimlerini saklayan ve
/// bu seçimlere göre fiyat çarpanlarını dinamik olarak hesaplayan veri modelidir.
class VehicleFilterModel {
  /// Kullanım türü: 'Şahsi' veya 'Ticari'
  final String usageType;

  /// Kullanım bölgesi: 'Şehir İçi' veya 'Şehir Dışı'
  final String locationScope;

  const VehicleFilterModel({
    required this.usageType,
    required this.locationScope,
  });

  /// [ÜST AÇIKLAMA]: Başlangıç için varsayılan filtre değerlerini üretir (Şahsi ve Şehir İçi).
  factory VehicleFilterModel.initial() {
    return const VehicleFilterModel(
      usageType: 'Şahsi',
      locationScope: 'Şehir İçi',
    );
  }
  // [ALT AÇIKLAMA]: Kullanıcı seçim yapmadan önce uygulamanın güvenli varsayılanlarla açılmasını sağlar.

  /// [ÜST AÇIKLAMA]: Kullanım amacına göre fiyat çarpanını hesaplar.
  /// Kural: Şahsi = 1.0 (1x), Ticari = 2.0 (2x).
  double get usageMultiplier {
    if (usageType == 'Ticari') {
      return 2.0;
    }
    return 1.0;
  }
  // [ALT AÇIKLAMA]: Ticari araçlar daha yoğun kullanım gerektirdiği için 2 kat çarpan uygulanır.

  /// [ÜST AÇIKLAMA]: Kullanım lokasyonuna göre fiyat çarpanını hesaplar.
  /// Kural: Şehir İçi = 1.0 (1x), Şehir Dışı = 2.0 (2x).
  double get locationMultiplier {
    if (locationScope == 'Şehir Dışı') {
      return 2.0;
    }
    return 1.0;
  }
  // [ALT AÇIKLAMA]: Şehir dışı yolculuklarda km ve yıpranma payı yüksek olduğundan 2 kat çarpan uygulanır.

  /// [ÜST AÇIKLAMA]: Toplam nihai kiralama çarpanını hesaplar.
  /// Formül: usageMultiplier * locationMultiplier
  /// Sonuçlar:
  /// - Şahsi + Şehir İçi = 1.0 x 1.0 = 1x
  /// - Şahsi + Şehir Dışı = 1.0 x 2.0 = 2x
  /// - Ticari + Şehir İçi = 2.0 x 1.0 = 2x
  /// - Ticari + Şehir Dışı = 2.0 x 2.0 = 4x
  double get totalMultiplier {
    return usageMultiplier * locationMultiplier;
  }
  // [ALT AÇIKLAMA]: Dinamik fiyatlandırma motoru bu çarpanı araç baz ücreti ve süreyle çarparak maliyeti bulur.

  /// [ÜST AÇIKLAMA]: Mevcut modelin kopyasını alıp yalnızca seçilen alanları güncelleyen copyWith metodu.
  VehicleFilterModel copyWith({
    String? usageType,
    String? locationScope,
  }) {
    return VehicleFilterModel(
      usageType: usageType ?? this.usageType,
      locationScope: locationScope ?? this.locationScope,
    );
  }
  // [ALT AÇIKLAMA]: Değişmezlik prensibi korunarak yeni nesne oluşturulur.

  /// [ÜST AÇIKLAMA]: JSON haritasından model üreten factory kurucu.
  factory VehicleFilterModel.fromJson(Map<String, dynamic> json) {
    return VehicleFilterModel(
      usageType: json['usageType'] as String? ?? 'Şahsi',
      locationScope: json['locationScope'] as String? ?? 'Şehir İçi',
    );
  }
  // [ALT AÇIKLAMA]: JSON verisinden modeli yeniden oluşturur.

  /// [ÜST AÇIKLAMA]: Modeli JSON haritasına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      'usageType': usageType,
      'locationScope': locationScope,
    };
  }
  // [ALT AÇIKLAMA]: Serileştirilebilir Map yapısı döndürür.
}
// [ALT AÇIKLAMA]: VehicleFilterModel, fiyatlandırma iş kurallarını merkezileştirerek
// UI katmanında mantık karmaşasını tamamen ortadan kaldırır.
