import 'dart:async';
import 'package:flutter/foundation.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalController, kiralanan aracın kalan kullanım süresini
/// saniye hassasiyetinde reaktif olarak sayan ve aracın teslim işlemlerini yöneten sınıftır.
/// Sayfa düzeyinde ağır setState kullanmak yerine hafif ValueNotifier tercih edilmiştir.
class ActiveRentalController {
  /// Kalan toplam süreyi saniye cinsinden tutan reaktif ValueNotifier
  final ValueNotifier<int> remainingSeconds = ValueNotifier<int>(0);

  /// Kiralama süresinin dolup dolmadığını bildiren notifier
  final ValueNotifier<bool> isExpiredNotifier = ValueNotifier<bool>(false);

  Timer? _timer;

  /// [ÜST AÇIKLAMA]: Kiralama süresini başlatır ve Timer.periodic ile her 1 saniyede
  /// kalan süreyi 1 azaltarak ValueNotifier'ı günceller.
  void startCountdown(int totalSeconds) {
    _timer?.cancel();
    remainingSeconds.value = totalSeconds > 0 ? totalSeconds : 0;
    isExpiredNotifier.value = remainingSeconds.value == 0;

    if (remainingSeconds.value <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value -= 1;
      } else {
        isExpiredNotifier.value = true;
        timer.cancel();
      }
    });
  }
  // [ALT AÇIKLAMA]: Her saniye ValueNotifier tetiklenir ve UI'da sadece sayacın olduğu widget güncellenir.

  /// [ÜST AÇIKLAMA]: Kullanıcı aracı teslim ettiğinde çalışan metot.
  /// Sayacı anında durdurur ve kalan süreyi sıfırlar.
  void stopAndDeliverVehicle() {
    _timer?.cancel();
    remainingSeconds.value = 0;
  }
  // [ALT AÇIKLAMA]: Bellek sızıntılarını önlemek için aktif periyodik timer güvenle iptal edilir.

  /// [ÜST AÇIKLAMA]: Saniye cinsinden verilen süreyi 'Gün : Saat : Dk : Sn' formatına dönüştürür.
  /// Örnek: 90061 saniye -> "01 Gün : 01 Saat : 01 Dk : 01 Sn"
  static String formatDuration(int totalSecs) {
    if (totalSecs <= 0) {
      return '00 Gün : 00 Saat : 00 Dk : 00 Sn';
    }

    final int days = totalSecs ~/ 86400;
    final int hours = (totalSecs % 86400) ~/ 3600;
    final int minutes = (totalSecs % 3600) ~/ 60;
    final int seconds = totalSecs % 60;

    final String dStr = days.toString().padLeft(2, '0');
    final String hStr = hours.toString().padLeft(2, '0');
    final String mStr = minutes.toString().padLeft(2, '0');
    final String sStr = seconds.toString().padLeft(2, '0');

    return '$dStr Gün : $hStr Saat : $mStr Dk : $sStr Sn';
  }
  // [ALT AÇIKLAMA]: padLeft(2, '0') metoduyla tek haneli rakamlar çift haneli dijital saat formatına getirilir.

  /// [ÜST AÇIKLAMA]: Controller yok edildiğinde timer'ı ve ValueNotifier'ları bellekten temizler.
  void dispose() {
    _timer?.cancel();
    remainingSeconds.dispose();
    isExpiredNotifier.dispose();
  }
  // [ALT AÇIKLAMA]: Dispose metodu çağrılarak uygulama hafızasında dangling timer kalması engellenir.
}
// [ALT AÇIKLAMA]: ActiveRentalController, canlı zaman yönetimini Flutter'ın
// en temiz ve performanslı yerel apileriyle (Timer + ValueNotifier) çözer.
