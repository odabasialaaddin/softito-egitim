import 'package:flutter/material.dart';

import '../models/vehicle_filter_model.dart';

/// [ÜST AÇIKLAMA]: VehicleFilterController, kullanıcının araç kullanım amacı ve
/// lokasyon seçimlerini yönetir. ValueNotifier ile reaktif olarak dinlenebilir
/// ve ağır setState kullanmadan filtre değişimlerini ekrana yansıtır.
class VehicleFilterController {
  /// Filtre modelini tutan reaktif ValueNotifier
  final ValueNotifier<VehicleFilterModel> filterNotifier;

  /// Kullanım türü seçenekleri
  static const List<String> usageOptions = ['Şahsi', 'Ticari'];

  /// Kullanım lokasyonu seçenekleri
  static const List<String> locationOptions = ['Şehir İçi', 'Şehir Dışı'];

  VehicleFilterController({VehicleFilterModel? initialFilter})
    : filterNotifier = ValueNotifier<VehicleFilterModel>(
        initialFilter ?? VehicleFilterModel.initial(),
      );

  /// [ÜST AÇIKLAMA]: Anlık aktif filtre modelini döndüren getter.
  VehicleFilterModel get currentFilter => filterNotifier.value;
  // [ALT AÇIKLAMA]: ValueNotifier içindeki güncel VehicleFilterModel değerine erişim sağlar.

  /// [ÜST AÇIKLAMA]: Kullanıcının Şahsi veya Ticari seçimini günceller.
  /// Bu seçim araç listesini filtrelemede kullanılır ve 1x/2x çarpanını etkiler.
  void setUsageType(String usageType) {
    if (filterNotifier.value.usageType != usageType) {
      filterNotifier.value = filterNotifier.value.copyWith(
        usageType: usageType,
      );
    }
  }
  // [ALT AÇIKLAMA]: Sadece değer değiştiğinde yeni nesne atanarak gereksiz tetiklemeler önlenir.

  /// [ÜST AÇIKLAMA]: Kullanıcının Şehir İçi veya Şehir Dışı seçimini günceller.
  /// Bu seçim araç listesini filtrelemez, ancak nihai fiyatı 1x/2x olarak çarpar.
  void setLocationScope(String locationScope) {
    if (filterNotifier.value.locationScope != locationScope) {
      filterNotifier.value = filterNotifier.value.copyWith(
        locationScope: locationScope,
      );
    }
  }
  // [ALT AÇIKLAMA]: Lokasyon kapsamı güncellendiğinde toplam çarpan otomatik olarak yeniden hesaplanır.

  /// [ÜST AÇIKLAMA]: Controller yok edildiğinde bellek sızıntısını önlemek için notifier'ı kapatır.
  void dispose() {
    filterNotifier.dispose();
  }
  // [ALT AÇIKLAMA]: ValueNotifier'ın dinleyicileri temizlenerek bellek serbest bırakılır.
}
// [ALT AÇIKLAMA]: VehicleFilterController, iş mantığını ve filtre durumunu
// tamamen soyutlayarak UI bileşenlerinin hafif ve sade kalmasını sağlar.
