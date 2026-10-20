import 'package:flutter/foundation.dart';
import '../models/donation_reminder_model.dart';

/// Düzenli kan bağışı aralıklarını ve bildirim tercihlerini yöneten reaktif kontrolcü.
class DonationRemindersController {
  late final ValueNotifier<List<DonationReminder>> remindersNotifier;
  final ValueNotifier<int> daysUntilEligibleNotifier = ValueNotifier<int>(24);

  DonationRemindersController() {
    _initDefaults();
  }

  void _initDefaults() {
    remindersNotifier = ValueNotifier<List<DonationReminder>>([
      const DonationReminder(
        id: 'rem-1',
        title: '3 Aylık Düzenli Bağış Zamanı',
        description: 'Vücudunuzun kan hücreleri tamamen yenilendi. Yeni bağış yapabilirsiniz.',
        targetDate: '15 Kasım 2026',
        bloodType: '0 Rh+',
        isActive: true,
        daysLeft: 24,
      ),
      const DonationReminder(
        id: 'rem-2',
        title: 'Kış Sezonu Kan Stoğu Desteği',
        description: 'Kış aylarında azalan Kızılay kan stoklarına destek olun.',
        targetDate: '01 Aralık 2026',
        bloodType: '0 Rh+',
        isActive: true,
        daysLeft: 40,
      ),
      const DonationReminder(
        id: 'rem-3',
        title: 'Yıllık Sağlık & Hemoglobin Kontrolü',
        description: 'Kan bağışı öncesi tansiyon ve kan değerlerinizi kontrol ettirin.',
        targetDate: '15 Ocak 2027',
        bloodType: '0 Rh+',
        isActive: false,
        daysLeft: 85,
      ),
    ]);
  }

  /// Bildirim aktif/pasif durumunu değiştirir
  void toggleReminder(String id) {
    remindersNotifier.value = remindersNotifier.value.map((reminder) {
      if (reminder.id == id) {
        return reminder.copyWith(isActive: !reminder.isActive);
      }
      return reminder;
    }).toList();
  }

  /// Yeni hatırlatıcı ekler
  void addReminder(DonationReminder reminder) {
    remindersNotifier.value = [reminder, ...remindersNotifier.value];
  }

  /// Hatırlatıcıyı siler
  void deleteReminder(String id) {
    remindersNotifier.value =
        remindersNotifier.value.where((r) => r.id != id).toList();
  }

  void dispose() {
    remindersNotifier.dispose();
    daysUntilEligibleNotifier.dispose();
  }
}
