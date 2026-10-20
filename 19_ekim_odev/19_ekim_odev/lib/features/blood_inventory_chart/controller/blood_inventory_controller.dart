import 'package:flutter/foundation.dart';
import '../models/blood_inventory_model.dart';

/// Kan grubu stok seviyelerini ve grafik seçimlerini yöneten reaktif kontrolcü.
class BloodInventoryController {
  static const List<BloodGroupStock> _defaultStocks = [
    BloodGroupStock(
      bloodType: 'A Rh+',
      currentUnits: 68,
      targetUnits: 100,
      minSafeUnits: 25,
      lastUpdated: '10 dk önce',
    ),
    BloodGroupStock(
      bloodType: 'A Rh-',
      currentUnits: 18, // Kritik
      targetUnits: 60,
      minSafeUnits: 20,
      lastUpdated: '25 dk önce',
    ),
    BloodGroupStock(
      bloodType: 'B Rh+',
      currentUnits: 45,
      targetUnits: 80,
      minSafeUnits: 25,
      lastUpdated: '1 saat önce',
    ),
    BloodGroupStock(
      bloodType: 'B Rh-',
      currentUnits: 14, // Kritik
      targetUnits: 50,
      minSafeUnits: 18,
      lastUpdated: '40 dk önce',
    ),
    BloodGroupStock(
      bloodType: 'AB Rh+',
      currentUnits: 32,
      targetUnits: 50,
      minSafeUnits: 15,
      lastUpdated: '2 saat önce',
    ),
    BloodGroupStock(
      bloodType: 'AB Rh-',
      currentUnits: 9, // Kritik
      targetUnits: 40,
      minSafeUnits: 12,
      lastUpdated: '15 dk önce',
    ),
    BloodGroupStock(
      bloodType: '0 Rh+',
      currentUnits: 84,
      targetUnits: 120,
      minSafeUnits: 30,
      lastUpdated: '5 dk önce',
    ),
    BloodGroupStock(
      bloodType: '0 Rh-',
      currentUnits: 22, // Kritik
      targetUnits: 80,
      minSafeUnits: 28,
      lastUpdated: '3 dk önce',
    ),
  ];

  /// Tüm kan gruplarının stok listesi
  final ValueNotifier<List<BloodGroupStock>> stocksNotifier =
      ValueNotifier<List<BloodGroupStock>>(_defaultStocks);

  /// Grafikte veya listede seçili olan kan grubu (örn: 'A Rh+')
  final ValueNotifier<String?> selectedBloodTypeNotifier =
      ValueNotifier<String?>(null);

  /// Toplam mevcut ünite sayısı
  int get totalUnits =>
      stocksNotifier.value.fold(0, (sum, item) => sum + item.currentUnits);

  /// Toplam hedeflenen ünite sayısı
  int get totalTargetUnits =>
      stocksNotifier.value.fold(0, (sum, item) => sum + item.targetUnits);

  /// Kritik stoktaki grup sayısı
  int get criticalGroupCount =>
      stocksNotifier.value.where((item) => item.isCritical).length;

  /// Grafikte bir kan grubu seçildiğinde tetiklenir
  void selectBloodType(String? bloodType) {
    if (selectedBloodTypeNotifier.value == bloodType) {
      selectedBloodTypeNotifier.value = null; // Seçimi kaldır
    } else {
      selectedBloodTypeNotifier.value = bloodType;
    }
  }

  /// Belirtilen kan grubuna bağış/stok ekler
  void addUnits(String bloodType, int count) {
    final updatedList = stocksNotifier.value.map((stock) {
      if (stock.bloodType == bloodType) {
        return stock.copyWith(
          currentUnits: (stock.currentUnits + count).clamp(0, stock.targetUnits * 2),
          lastUpdated: 'Az önce',
        );
      }
      return stock;
    }).toList();

    stocksNotifier.value = updatedList;
  }

  /// Belirtilen kan grubundan kullanım/çıkış yapar
  void removeUnits(String bloodType, int count) {
    final updatedList = stocksNotifier.value.map((stock) {
      if (stock.bloodType == bloodType) {
        return stock.copyWith(
          currentUnits: (stock.currentUnits - count).clamp(0, stock.targetUnits * 2),
          lastUpdated: 'Az önce',
        );
      }
      return stock;
    }).toList();

    stocksNotifier.value = updatedList;
  }

  /// Stokları varsayılan duruma sıfırlar
  void resetToDefaults() {
    stocksNotifier.value = _defaultStocks;
    selectedBloodTypeNotifier.value = null;
  }

  void dispose() {
    stocksNotifier.dispose();
    selectedBloodTypeNotifier.dispose();
  }
}
