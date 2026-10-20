import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/features/active_rental/controller/active_rental_controller.dart';
import 'package:kirala/features/active_rental/models/active_rental_model.dart';
import 'package:kirala/features/vehicle_catalog/models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: ActiveRental birim testleri, canlı geri sayım sayacının (Timer)
/// başlatılmasını, saniye saniye azalmasını, teslim edildiğinde sıfırlanmasını ve
/// ActiveRentalModel modelinin toplam saniye hesaplama doğruluğunu test eder.
void main() {
  group('ActiveRentalController Canlı Sayaç ve Teslim Testleri', () {
    late ActiveRentalController controller;

    setUp(() {
      controller = ActiveRentalController();
    });

    tearDown(() {
      controller.dispose();
    });

    /// [ÜST AÇIKLAMA]: startCountdown metodunun başlangıç saniyesini doğru atadığını ve
    /// her saniye azaldığını asenkron test ile doğrular.
    test('startCountdown sayacı başlatmalı ve saniye bazında azaltmalıdır', () async {
      controller.startCountdown(5);
      expect(controller.remainingSeconds.value, equals(5));

      // 1.1 saniye bekleyerek Timer'ın 1 kez tetiklenmesini gözlemle
      await Future<void>.delayed(const Duration(milliseconds: 1100));
      expect(controller.remainingSeconds.value, equals(4));
    });
    // [ALT AÇIKLAMA]: Timer.periodic tetiklenmesi ve saniyelik reaktif azalma doğrulandı.

    /// [ÜST AÇIKLAMA]: stopAndDeliverVehicle çağrıldığında sayacın anında 0 olduğunu doğrular.
    test('stopAndDeliverVehicle sayacı durdurup kalan süreyi 0 yapmalıdır', () {
      controller.startCountdown(100);
      expect(controller.remainingSeconds.value, equals(100));

      controller.stopAndDeliverVehicle();
      expect(controller.remainingSeconds.value, equals(0));
    });
    // [ALT AÇIKLAMA]: Araç teslimi sonrası durumun güvenle sıfırlandığı kanıtlandı.

    /// [ÜST AÇIKLAMA]: formatDuration metodunun saniyeyi 'Gün : Saat : Dk : Sn' formatına çevirdiğini test eder.
    test('formatDuration saniyeyi çift haneli Gün:Saat:Dk:Sn formatına dönüştürmelidir', () {
      // 0 saniye
      expect(
        ActiveRentalController.formatDuration(0),
        equals('00 Gün : 00 Saat : 00 Dk : 00 Sn'),
      );

      // 3661 saniye = 1 saat, 1 dakika, 1 saniye
      expect(
        ActiveRentalController.formatDuration(3661),
        equals('00 Gün : 01 Saat : 01 Dk : 01 Sn'),
      );

      // 90061 saniye = 1 gün, 1 saat, 1 dakika, 1 saniye
      expect(
        ActiveRentalController.formatDuration(90061),
        equals('01 Gün : 01 Saat : 01 Dk : 01 Sn'),
      );
    });
    // [ALT AÇIKLAMA]: Dijital gösterge metin formatlaması doğrulandı.
  });

  group('ActiveRentalModel Toplam Saniye ve Süre Testleri', () {
    const sampleVehicle = VehicleModel(
      id: 'test_car',
      brandModel: 'Tesla Model Y',
      chassisNo: 'XP7YGCEEKRB123456',
      modelYear: 2026,
      usageType: 'Şahsi',
      baseHourlyRate: 450.0,
      baseDailyRate: 3600.0,
      fuelType: 'Elektrik',
      transmission: 'Otomatik',
    );

    /// [ÜST AÇIKLAMA]: Saatlik kiralama süresinin saniyeye çevrilmesini test eder (saat * 3600).
    test('Saatlik kiralama için totalSeconds = saat * 3600 olmalıdır', () {
      final hourlyRental = ActiveRentalModel(
        vehicle: sampleVehicle,
        rentalType: 'Saatlik',
        duration: 3,
        totalCost: 1350.0,
        locationScope: 'Şehir İçi',
        usageType: 'Şahsi',
        startTime: DateTime.now(),
      );
      // 3 saat * 3600 saniye = 10800 saniye
      expect(hourlyRental.totalSeconds, equals(10800));
    });
    // [ALT AÇIKLAMA]: Saatlik toplam saniye hesabı doğrulandı.

    /// [ÜST AÇIKLAMA]: Günlük kiralama süresinin saniyeye çevrilmesini test eder (gün * 86400).
    test('Günlük kiralama için totalSeconds = gün * 86400 olmalıdır', () {
      final dailyRental = ActiveRentalModel(
        vehicle: sampleVehicle,
        rentalType: 'Günlük',
        duration: 2,
        totalCost: 7200.0,
        locationScope: 'Şehir Dışı',
        usageType: 'Şahsi',
        startTime: DateTime.now(),
      );
      // 2 gün * 86400 saniye = 172800 saniye
      expect(dailyRental.totalSeconds, equals(172800));
    });
    // [ALT AÇIKLAMA]: Günlük toplam saniye hesabı doğrulandı.
  });
}
// [ALT AÇIKLAMA]: Aktif kiralama ve sayaç modülü birim testlerle tam olarak doğrulandı.
