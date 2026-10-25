/// [ÜST AÇIKLAMA]: VehicleModel, Kirala platformundaki araçların teknik ve fiyatlandırma
/// özelliklerini tutan değişmez (immutable) veri modelidir.
/// 17 haneli şase numarası (VIN), model yılı, saatlik/günlük baz ücretler gibi kritik verileri barındırır.
class VehicleModel {
  final String id;
  final String brandModel;
  final String chassisNo; // 17 haneli standart VIN
  final int modelYear;
  final String usageType; // 'Şahsi' veya 'Ticari'
  final double baseHourlyRate; // TL cinsinden baz saatlik kiralama ücreti
  final double baseDailyRate; // TL cinsinden baz günlük kiralama ücreti
  final String fuelType; // 'Benzin', 'Dizel', 'Elektrik', 'Hibrit'
  final String transmission; // 'Otomatik', 'Manuel'
  final String imageUrl; // Araç simgesi veya görsel anahtarı

  const VehicleModel({
    required this.id,
    required this.brandModel,
    required this.chassisNo,
    required this.modelYear,
    required this.usageType,
    required this.baseHourlyRate,
    required this.baseDailyRate,
    required this.fuelType,
    required this.transmission,
    this.imageUrl = '',
  });

  /// [ÜST AÇIKLAMA]: Nesne üzerinde belirli alanları değiştirerek yeni kopya üretir.
  VehicleModel copyWith({
    String? id,
    String? brandModel,
    String? chassisNo,
    int? modelYear,
    String? usageType,
    double? baseHourlyRate,
    double? baseDailyRate,
    String? fuelType,
    String? transmission,
    String? imageUrl,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      brandModel: brandModel ?? this.brandModel,
      chassisNo: chassisNo ?? this.chassisNo,
      modelYear: modelYear ?? this.modelYear,
      usageType: usageType ?? this.usageType,
      baseHourlyRate: baseHourlyRate ?? this.baseHourlyRate,
      baseDailyRate: baseDailyRate ?? this.baseDailyRate,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
  // [ALT AÇIKLAMA]: Null gelen argümanlar yerine mevcut model değerleri korunur.

  /// [ÜST AÇIKLAMA]: JSON haritasını VehicleModel nesnesine dönüştürür.
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String? ?? '',
      brandModel: json['brandModel'] as String? ?? '',
      chassisNo: json['chassisNo'] as String? ?? '',
      modelYear: (json['modelYear'] as num?)?.toInt() ?? 2024,
      usageType: json['usageType'] as String? ?? 'Şahsi',
      baseHourlyRate: (json['baseHourlyRate'] as num?)?.toDouble() ?? 0.0,
      baseDailyRate: (json['baseDailyRate'] as num?)?.toDouble() ?? 0.0,
      fuelType: json['fuelType'] as String? ?? 'Benzin',
      transmission: json['transmission'] as String? ?? 'Otomatik',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
  // [ALT AÇIKLAMA]: Sayısal dönüşümler güvenli num cast ile yapılarak veri tipi hataları engellenir.

  /// [ÜST AÇIKLAMA]: Modeli JSON Map formatına çevirir.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandModel': brandModel,
      'chassisNo': chassisNo,
      'modelYear': modelYear,
      'usageType': usageType,
      'baseHourlyRate': baseHourlyRate,
      'baseDailyRate': baseDailyRate,
      'fuelType': fuelType,
      'transmission': transmission,
      'imageUrl': imageUrl,
    };
  }
  // [ALT AÇIKLAMA]: Model serileştirilerek saklanmaya uygun hale getirilir.
}
// [ALT AÇIKLAMA]: VehicleModel, araç katalog verisinin güvenli, tip korumalı
// ve tutarlı bir şekilde yönetilmesini garanti altına alır.
