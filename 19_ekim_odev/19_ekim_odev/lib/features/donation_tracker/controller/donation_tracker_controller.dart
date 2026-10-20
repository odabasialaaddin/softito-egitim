import 'package:flutter/foundation.dart';
import '../models/donation_tracker_model.dart';

/// Kan bağışçısı profilini ve bağış ilerlemesini yöneten reaktif kontrolcü.
class DonationTrackerController {
  final int targetUnits = 6; // Yıllık bağış hedefi

  late final ValueNotifier<DonorProfile> donorProfileNotifier;
  late final ValueNotifier<List<DonationRecord>> historyNotifier;
  late final ValueNotifier<int> currentDonatedUnits;

  DonationTrackerController() {
    _initDefaults();
  }

  void _initDefaults() {
    donorProfileNotifier = ValueNotifier<DonorProfile>(
      const DonorProfile(
        name: 'Ahmet Yılmaz',
        bloodType: '0 Rh+',
        profileImage: '',
        donationCount: 3,
        healthPoints: 450,
        lastDonationDate: '15 Ağustos 2026',
        nextEligibleDate: '15 Kasım 2026',
      ),
    );

    currentDonatedUnits = ValueNotifier<int>(3);

    historyNotifier = ValueNotifier<List<DonationRecord>>([
      const DonationRecord(
        id: 'rec-1',
        date: '15 Ağustos 2026',
        units: 1,
        location: 'Kızılay Kadıköy Kan Merkezi',
        bloodType: '0 Rh+',
      ),
      const DonationRecord(
        id: 'rec-2',
        date: '10 Mayıs 2026',
        units: 1,
        location: 'Şişli Mobil Kan Aracı',
        bloodType: '0 Rh+',
      ),
      const DonationRecord(
        id: 'rec-3',
        date: '12 Şubat 2026',
        units: 1,
        location: 'Kartal Dr. Lütfi Kırdar Hastanesi',
        bloodType: '0 Rh+',
      ),
    ]);
  }

  /// Doluluk oranı (0.0 - 1.0)
  double get fillRatio =>
      (currentDonatedUnits.value / targetUnits).clamp(0.0, 1.0);

  /// Yeni bir bağış ekler
  void addDonation({
    String location = 'Merkez Kan Alma İstasyonu',
    String bloodType = '0 Rh+',
  }) {
    final newCount = currentDonatedUnits.value + 1;
    currentDonatedUnits.value = newCount;

    final profile = donorProfileNotifier.value;
    donorProfileNotifier.value = profile.copyWith(
      donationCount: newCount,
      healthPoints: profile.healthPoints + 150,
      lastDonationDate: 'Bugün',
      nextEligibleDate: '90 gün sonra',
    );

    final newRecord = DonationRecord(
      id: 'rec-${DateTime.now().millisecondsSinceEpoch}',
      date: 'Bugün',
      units: 1,
      location: location,
      bloodType: bloodType,
    );

    historyNotifier.value = [newRecord, ...historyNotifier.value];
  }

  /// Bağış sayısını ve geçmişi sıfırlar
  void resetDonations() {
    currentDonatedUnits.value = 0;
    final profile = donorProfileNotifier.value;
    donorProfileNotifier.value = profile.copyWith(
      donationCount: 0,
      healthPoints: 0,
      lastDonationDate: 'Henüz bağış yok',
      nextEligibleDate: 'Hemen bağışlanabilir',
    );
    historyNotifier.value = [];
  }

  void dispose() {
    donorProfileNotifier.dispose();
    historyNotifier.dispose();
    currentDonatedUnits.dispose();
  }
}
