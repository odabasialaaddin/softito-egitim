import '../../vehicle_catalog/models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalModel, kullanıcı tarafından kiralanan aktif aracın
/// tüm sözleşme, süre, maliyet ve başlangıç zamanı verilerini barındıran değişmez (immutable) modeldir.
/// Canlı geri sayım sayacı ve araç teslim akışında kullanılır.
class ActiveRentalModel {
  final VehicleModel vehicle;
  final String rentalType; // 'Saatlik' veya 'Günlük'
  final int duration; // Saat veya gün sayısı
  final double totalCost; // TL cinsinden nihai maliyet
  final String locationScope; // 'Şehir İçi' veya 'Şehir Dışı'
  final String usageType; // 'Şahsi' veya 'Ticari'
  final DateTime startTime;

  const ActiveRentalModel({
    required this.vehicle,
    required this.rentalType,
    required this.duration,
    required this.totalCost,
    required this.locationScope,
    required this.usageType,
    required this.startTime,
  });

  /// [ÜST AÇIKLAMA]: Kiralama türüne göre toplam süreyi saniye cinsinden hesaplar.
  /// Saatlik ise süre * 3600, Günlük ise süre * 86400 saniye döner.
  int get totalSeconds {
    if (rentalType == 'Günlük') {
      return duration * 86400;
    }
    return duration * 3600;
  }
  // [ALT AÇIKLAMA]: Canlı saniye sayacına (Timer) aktarılacak başlangıç değerini üretir.

  /// [ÜST AÇIKLAMA]: Modeli kopyalayıp istenen alanları güncelleyerek yeni nesne üretir.
  ActiveRentalModel copyWith({
    VehicleModel? vehicle,
    String? rentalType,
    int? duration,
    double? totalCost,
    String? locationScope,
    String? usageType,
    DateTime? startTime,
  }) {
    return ActiveRentalModel(
      vehicle: vehicle ?? this.vehicle,
      rentalType: rentalType ?? this.rentalType,
      duration: duration ?? this.duration,
      totalCost: totalCost ?? this.totalCost,
      locationScope: locationScope ?? this.locationScope,
      usageType: usageType ?? this.usageType,
      startTime: startTime ?? this.startTime,
    );
  }
  // [ALT AÇIKLAMA]: İmmutable yapı korunarak güncelleme yapılması sağlanır.

  /// [ÜST AÇIKLAMA]: JSON haritasından model üreten factory metodu.
  factory ActiveRentalModel.fromJson(Map<String, dynamic> json) {
    return ActiveRentalModel(
      vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
      rentalType: json['rentalType'] as String? ?? 'Saatlik',
      duration: (json['duration'] as num?)?.toInt() ?? 1,
      totalCost: (json['totalCost'] as num?)?.toDouble() ?? 0.0,
      locationScope: json['locationScope'] as String? ?? 'Şehir İçi',
      usageType: json['usageType'] as String? ?? 'Şahsi',
      startTime: DateTime.tryParse(json['startTime'] as String? ?? '') ??
          DateTime.now(),
    );
  }
  // [ALT AÇIKLAMA]: Nested vehicle nesnesi ve tarih formatı güvenle çözümlenir.

  /// [ÜST AÇIKLAMA]: Modeli JSON Map formatına çevirir.
  Map<String, dynamic> toJson() {
    return {
      'vehicle': vehicle.toJson(),
      'rentalType': rentalType,
      'duration': duration,
      'totalCost': totalCost,
      'locationScope': locationScope,
      'usageType': usageType,
      'startTime': startTime.toIso8601String(),
    };
  }
  // [ALT AÇIKLAMA]: Tüm veriler JSON uyumlu hale getirilir.
}
// [ALT AÇIKLAMA]: ActiveRentalModel, kiralama oturumu boyunca durum tutarlılığını garanti eder.
