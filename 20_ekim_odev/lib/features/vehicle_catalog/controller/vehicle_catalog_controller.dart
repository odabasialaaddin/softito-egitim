import '../models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: VehicleCatalogController, araç katalog verisini,
/// kategoriye göre filtreleme işlemlerini ve kiralama tipi/çarpanlarına göre
/// dinamik maliyet hesaplama algoritmasını barındıran iş mantığı kontrolcüsüdür.
class VehicleCatalogController {
  /// Zengin araç envanteri (En az 4 Şahsi binek/SUV ve en az 4 Ticari araç)
  /// Tüm araçlar 17 haneli şase numarasına (VIN) ve gerçekçi baz ücretlere sahiptir.
  static const List<VehicleModel> defaultVehicleList = [
    // --- ŞAHSİ BİNEK & SUV ARAÇLAR ---
    VehicleModel(
      id: 'v_clio_2024',
      brandModel: 'Renault Clio 1.0 TCe Evolution',
      chassisNo: 'VF1RJA00568912345',
      modelYear: 2024,
      usageType: 'Şahsi',
      baseHourlyRate: 150.0,
      baseDailyRate: 1200.0,
      fuelType: 'Benzin',
      transmission: 'Otomatik',
    ),
    VehicleModel(
      id: 'v_corolla_2025',
      brandModel: 'Toyota Corolla 1.8 Hybrid Dream',
      chassisNo: 'NMTBZ23E40R123456',
      modelYear: 2025,
      usageType: 'Şahsi',
      baseHourlyRate: 180.0,
      baseDailyRate: 1450.0,
      fuelType: 'Hibrit',
      transmission: 'Otomatik',
    ),
    VehicleModel(
      id: 'v_tesla_2026',
      brandModel: 'Tesla Model Y Long Range AWD',
      chassisNo: 'XP7YGCEEKRB123456',
      modelYear: 2026,
      usageType: 'Şahsi',
      baseHourlyRate: 450.0,
      baseDailyRate: 3600.0,
      fuelType: 'Elektrik',
      transmission: 'Otomatik',
    ),
    VehicleModel(
      id: 'v_bmw_2024',
      brandModel: 'BMW 320i Sedan M Sport Edition',
      chassisNo: 'WBA5R11030F123456',
      modelYear: 2024,
      usageType: 'Şahsi',
      baseHourlyRate: 400.0,
      baseDailyRate: 3200.0,
      fuelType: 'Benzin',
      transmission: 'Otomatik',
    ),

    // --- TİCARİ ARAÇLAR ---
    VehicleModel(
      id: 'v_transit_2025',
      brandModel: 'Ford Transit Custom Van EcoBlue',
      chassisNo: 'WF0XXXTTGX1234567',
      modelYear: 2025,
      usageType: 'Ticari',
      baseHourlyRate: 250.0,
      baseDailyRate: 2000.0,
      fuelType: 'Dizel',
      transmission: 'Manuel',
    ),
    VehicleModel(
      id: 'v_doblo_2024',
      brandModel: 'Fiat Doblo Cargo Maxi Multijet',
      chassisNo: 'NM42630000R123456',
      modelYear: 2024,
      usageType: 'Ticari',
      baseHourlyRate: 200.0,
      baseDailyRate: 1600.0,
      fuelType: 'Dizel',
      transmission: 'Manuel',
    ),
    VehicleModel(
      id: 'v_transporter_2025',
      brandModel: 'Volkswagen Transporter 2.0 TDI',
      chassisNo: 'WV1ZZZ7HZNH123456',
      modelYear: 2025,
      usageType: 'Ticari',
      baseHourlyRate: 320.0,
      baseDailyRate: 2600.0,
      fuelType: 'Dizel',
      transmission: 'Otomatik',
    ),
    VehicleModel(
      id: 'v_vito_2026',
      brandModel: 'Mercedes-Benz Vito Tourer Pro 119',
      chassisNo: 'WDF44770313123456',
      modelYear: 2026,
      usageType: 'Ticari',
      baseHourlyRate: 380.0,
      baseDailyRate: 3100.0,
      fuelType: 'Dizel',
      transmission: 'Otomatik',
    ),
  ];

  final List<VehicleModel> _vehicles;

  VehicleCatalogController({List<VehicleModel>? vehicles})
      : _vehicles = vehicles ?? defaultVehicleList;

  /// [ÜST AÇIKLAMA]: Kullanıcının 1. adımda seçtiği kullanım türüne ('Şahsi' / 'Ticari')
  /// göre araç listesini filtreleyerek yalnızca ilgili kategorideki araçları döndürür.
  List<VehicleModel> getFilteredVehicles(String usageType) {
    return _vehicles
        .where((vehicle) =>
            vehicle.usageType.toLowerCase() == usageType.toLowerCase())
        .toList();
  }
  // [ALT AÇIKLAMA]: Şahsi seçildiğinde binek/SUV, Ticari seçildiğinde hafif ticari/panelvan araçlar döner.

  /// [ÜST AÇIKLAMA]: Dinamik kiralama maliyetini hesaplayan merkezi matematiksel algoritma.
  /// Formül: Baz Ücret x Şahsi/Ticari Çarpanı x Şehir İçi/Şehir Dışı Çarpanı x Süre
  double calculateRentalCost({
    required VehicleModel vehicle,
    required String rentalType, // 'Saatlik' veya 'Günlük'
    required int duration,
    required double usageMultiplier, // Şahsi: 1.0, Ticari: 2.0
    required double locationMultiplier, // Şehir İçi: 1.0, Şehir Dışı: 2.0
  }) {
    if (duration <= 0) return 0.0;

    final double baseRate = rentalType == 'Günlük'
        ? vehicle.baseDailyRate
        : vehicle.baseHourlyRate;

    final double totalMultiplier = usageMultiplier * locationMultiplier;
    return baseRate * totalMultiplier * duration;
  }
  // [ALT AÇIKLAMA]: Çarpanlar ve süre ile baz ücret katlanarak nihai TL maliyeti elde edilir.
}
// [ALT AÇIKLAMA]: VehicleCatalogController, fiyat hesaplama ve veri filtreleme
// mantığını tamamen merkezileştirerek birim testlerin kusursuz çalışmasını sağlar.
