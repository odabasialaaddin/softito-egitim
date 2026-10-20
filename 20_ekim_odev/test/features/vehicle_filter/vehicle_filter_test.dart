import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/features/vehicle_filter/controller/vehicle_filter_controller.dart';
import 'package:kirala/features/vehicle_filter/models/vehicle_filter_model.dart';

/// [ÜST AÇIKLAMA]: VehicleFilter birim testleri, Şahsi/Ticari (1x/2x) ve
/// Şehir İçi/Şehir Dışı (1x/2x) çarpan hesaplama kurallarının matematiksel doğruluğunu
/// ve controller durum güncellemelerini test eder.
void main() {
  group('VehicleFilterModel Çarpan Hesaplama Testleri', () {
    /// [ÜST AÇIKLAMA]: Şahsi ve Ticari kullanım çarpanlarını doğrular.
    test('Kullanım türü çarpanı Şahsi için 1.0x ve Ticari için 2.0x olmalıdır', () {
      const personalFilter = VehicleFilterModel(
        usageType: 'Şahsi',
        locationScope: 'Şehir İçi',
      );
      expect(personalFilter.usageMultiplier, equals(1.0));

      const commercialFilter = VehicleFilterModel(
        usageType: 'Ticari',
        locationScope: 'Şehir İçi',
      );
      expect(commercialFilter.usageMultiplier, equals(2.0));
    });
    // [ALT AÇIKLAMA]: Şahsi 1x, Ticari 2x kuralı doğrulandı.

    /// [ÜST AÇIKLAMA]: Şehir İçi ve Şehir Dışı lokasyon çarpanlarını doğrular.
    test('Lokasyon çarpanı Şehir İçi için 1.0x ve Şehir Dışı için 2.0x olmalıdır', () {
      const cityFilter = VehicleFilterModel(
        usageType: 'Şahsi',
        locationScope: 'Şehir İçi',
      );
      expect(cityFilter.locationMultiplier, equals(1.0));

      const outOfCityFilter = VehicleFilterModel(
        usageType: 'Şahsi',
        locationScope: 'Şehir Dışı',
      );
      expect(outOfCityFilter.locationMultiplier, equals(2.0));
    });
    // [ALT AÇIKLAMA]: Şehir İçi 1x, Şehir Dışı 2x kuralı doğrulandı.

    /// [ÜST AÇIKLAMA]: 4 temel kombinasyonun toplam çarpan sonuçlarını test eder.
    /// Kural:
    /// - Şahsi + Şehir İçi = 1x
    /// - Şahsi + Şehir Dışı = 2x
    /// - Ticari + Şehir İçi = 2x
    /// - Ticari + Şehir Dışı = 4x
    test('Toplam çarpan (totalMultiplier) 4 senaryoda da doğru hesaplanmalıdır', () {
      // Senaryo 1: Şahsi + Şehir İçi = 1.0 x 1.0 = 1.0
      const s1 = VehicleFilterModel(usageType: 'Şahsi', locationScope: 'Şehir İçi');
      expect(s1.totalMultiplier, equals(1.0));

      // Senaryo 2: Şahsi + Şehir Dışı = 1.0 x 2.0 = 2.0
      const s2 = VehicleFilterModel(usageType: 'Şahsi', locationScope: 'Şehir Dışı');
      expect(s2.totalMultiplier, equals(2.0));

      // Senaryo 3: Ticari + Şehir İçi = 2.0 x 1.0 = 2.0
      const s3 = VehicleFilterModel(usageType: 'Ticari', locationScope: 'Şehir İçi');
      expect(s3.totalMultiplier, equals(2.0));

      // Senaryo 4: Ticari + Şehir Dışı = 2.0 x 2.0 = 4.0
      const s4 = VehicleFilterModel(usageType: 'Ticari', locationScope: 'Şehir Dışı');
      expect(s4.totalMultiplier, equals(4.0));
    });
    // [ALT AÇIKLAMA]: Tüm matematiksel çarpan kombinasyonları eksiksiz teyit edildi.
  });

  group('VehicleFilterController Durum Yönetimi Testleri', () {
    late VehicleFilterController controller;

    setUp(() {
      controller = VehicleFilterController();
    });

    tearDown(() {
      controller.dispose();
    });

    /// [ÜST AÇIKLAMA]: Controller üzerindeki güncellemelerin reaktif ValueNotifier'a yansıdığını test eder.
    test('setUsageType ve setLocationScope reaktif modeli güncellemelidir', () {
      expect(controller.currentFilter.usageType, equals('Şahsi'));
      expect(controller.currentFilter.locationScope, equals('Şehir İçi'));
      expect(controller.currentFilter.totalMultiplier, equals(1.0));

      controller.setUsageType('Ticari');
      expect(controller.currentFilter.usageType, equals('Ticari'));
      expect(controller.currentFilter.totalMultiplier, equals(2.0));

      controller.setLocationScope('Şehir Dışı');
      expect(controller.currentFilter.locationScope, equals('Şehir Dışı'));
      expect(controller.currentFilter.totalMultiplier, equals(4.0));
    });
    // [ALT AÇIKLAMA]: Controller state güncellemelerinin tutarlılığı onaylandı.
  });
}
// [ALT AÇIKLAMA]: Araç filtreleme ve çarpan hesaplama mantığı birim testlerle mühürlendi.
