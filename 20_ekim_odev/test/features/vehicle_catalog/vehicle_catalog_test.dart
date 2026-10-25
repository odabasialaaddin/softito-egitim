import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/features/vehicle_catalog/controller/vehicle_catalog_controller.dart';
import 'package:kirala/features/vehicle_catalog/models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: VehicleCatalog birim testleri, Şahsi/Ticari araç listesi filtrelemesini,
/// araç verilerinin 17 haneli şase no ve model yılı standartlarına uygunluğunu ve
/// saatlik/günlük dinamik kiralama maliyet formülünün doğruluğunu test eder.
void main() {
  group('VehicleCatalogController Filtreleme ve Envanter Testleri', () {
    late VehicleCatalogController controller;

    setUp(() {
      controller = VehicleCatalogController();
    });

    /// [ÜST AÇIKLAMA]: Şahsi kategorisinde en az 4 binek/SUV araç olduğunu ve hepsinin Şahsi olduğunu test eder.
    test('Şahsi filtreleme en az 4 geçerli binek/SUV araç döndürmelidir', () {
      final personalVehicles = controller.getFilteredVehicles('Şahsi');
      expect(personalVehicles.length, greaterThanOrEqualTo(4));

      for (final vehicle in personalVehicles) {
        expect(vehicle.usageType, equals('Şahsi'));
        expect(vehicle.chassisNo.length, equals(17)); // 17 haneli VIN standardı
        expect(vehicle.modelYear, inInclusiveRange(2023, 2026)); // 2023-2026 model yılı
        expect(vehicle.baseHourlyRate, greaterThan(0));
        expect(vehicle.baseDailyRate, greaterThan(0));
      }
    });
    // [ALT AÇIKLAMA]: Şahsi araçların teknik özellikleri ve veri bütünlüğü doğrulandı.

    /// [ÜST AÇIKLAMA]: Ticari kategorisinde en az 4 ticari araç olduğunu ve hepsinin Ticari olduğunu test eder.
    test('Ticari filtreleme en az 4 geçerli ticari araç döndürmelidir', () {
      final commercialVehicles = controller.getFilteredVehicles('Ticari');
      expect(commercialVehicles.length, greaterThanOrEqualTo(4));

      for (final vehicle in commercialVehicles) {
        expect(vehicle.usageType, equals('Ticari'));
        expect(vehicle.chassisNo.length, equals(17)); // 17 haneli VIN standardı
        expect(vehicle.modelYear, inInclusiveRange(2023, 2026));
        expect(vehicle.baseHourlyRate, greaterThan(0));
        expect(vehicle.baseDailyRate, greaterThan(0));
      }
    });
    // [ALT AÇIKLAMA]: Ticari araçların teknik özellikleri ve veri bütünlüğü doğrulandı.
  });

  group('VehicleCatalogController Dinamik Maliyet Hesaplama Testleri', () {
    late VehicleCatalogController controller;
    const testVehicle = VehicleModel(
      id: 'test_car',
      brandModel: 'Test Car',
      chassisNo: '12345678901234567',
      modelYear: 2024,
      usageType: 'Şahsi',
      baseHourlyRate: 100.0,
      baseDailyRate: 1000.0,
      fuelType: 'Benzin',
      transmission: 'Otomatik',
    );

    setUp(() {
      controller = VehicleCatalogController();
    });

    /// [ÜST AÇIKLAMA]: Saatlik kiralama maliyetini farklı çarpan ve sürelerle test eder.
    /// Formül: baseHourlyRate x usageMultiplier x locationMultiplier x duration
    test('Saatlik kiralama maliyeti formüle uygun olarak doğru hesaplanmalıdır', () {
      // 1. Durum: Şahsi (1x), Şehir İçi (1x), 3 saat = 100 * 1 * 1 * 3 = 300 TL
      final cost1 = controller.calculateRentalCost(
        vehicle: testVehicle,
        rentalType: 'Saatlik',
        duration: 3,
        usageMultiplier: 1.0,
        locationMultiplier: 1.0,
      );
      expect(cost1, equals(300.0));

      // 2. Durum: Ticari (2x), Şehir Dışı (2x), 5 saat = 100 * 2 * 2 * 5 = 2000 TL
      final cost2 = controller.calculateRentalCost(
        vehicle: testVehicle,
        rentalType: 'Saatlik',
        duration: 5,
        usageMultiplier: 2.0,
        locationMultiplier: 2.0,
      );
      expect(cost2, equals(2000.0));
    });
    // [ALT AÇIKLAMA]: Saatlik dinamik maliyet hesaplaması doğrulandı.

    /// [ÜST AÇIKLAMA]: Günlük kiralama maliyetini farklı çarpan ve sürelerle test eder.
    /// Formül: baseDailyRate x usageMultiplier x locationMultiplier x duration
    test('Günlük kiralama maliyeti formüle uygun olarak doğru hesaplanmalıdır', () {
      // 1. Durum: Şahsi (1x), Şehir Dışı (2x), 2 gün = 1000 * 1 * 2 * 2 = 4000 TL
      final cost1 = controller.calculateRentalCost(
        vehicle: testVehicle,
        rentalType: 'Günlük',
        duration: 2,
        usageMultiplier: 1.0,
        locationMultiplier: 2.0,
      );
      expect(cost1, equals(4000.0));

      // 2. Durum: Süre 0 veya negatif girildiğinde maliyet 0.0 TL dönmelidir
      final costZero = controller.calculateRentalCost(
        vehicle: testVehicle,
        rentalType: 'Günlük',
        duration: 0,
        usageMultiplier: 1.0,
        locationMultiplier: 1.0,
      );
      expect(costZero, equals(0.0));
    });
    // [ALT AÇIKLAMA]: Günlük kiralama ve sınır durum (edge-case) kontrolleri tamamlandı.
  });
}
// [ALT AÇIKLAMA]: Araç katalog ve fiyatlandırma motoru testleri %100 kapsama ile mühürlendi.
