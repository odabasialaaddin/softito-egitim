name:flutter-feature-scaffold
description:Flutter projelerinde feature bazlı kod yazmak için gerekli klasör yapısını oluşturur.
valueNotifier state mimarisini, form/validasyon yönetimini, Material 3 diyalog/buton etkileşimlerini, öğretici yorum satırlarını ve birim test iskeletini standartlara uygun olarak üretir.
# Flutter feature scaffold(modüler ekran iskeleti)
bu yetenek, projede yeni bir ekran yada işlev modülü açarken clean UI, reaktif state ve öğretici kod açıklama kurallarına tam uyulmasını garanti altına alır.
## Temel kurallar
1. **Asla tek dosyada toplama:** UI ('_view.dart') State controller
('_controller.dart') ve model
('_model.dart') dosyaları ayrı ayrı açılmalıdır.

2. **State Yönetimi:**
Basit ve reaktif durumlar için `ValueNotifier` kullanılmalıdır. doğrudan devasa statefulWidget yazarak işi karmaşıklaştırma.

3. **const zorunluluğu:** mümkün olan tüm widgetlarda const olmalıdır.

4. **Öğretici Açıklama Satırları:** Her kod bloğunun üstünde ve altında, kod yazma mantığını öğreten detaylı Türkçe açıklama satırları yer almalıdır.

## adım adım uygulama akışı
### adım 1: klasör yapısını oluşturma
Hedeflenen modül adlarını (örn: 'active_rental'), 'lib/features/<feature_name>' altına yapıyı kur

```text
lib/features/<feature_name>
    controller/
        <feature_name>_controller.dart
    models/
        <feature_name>_model.dart
    view/
        <feature_name>_view.dart
    widget/
        <feature_name>_card.dart
```
    
### Adım 2: Controller Dosyasını Yaz
`controller/<feature_name>_controller.dart` içinde mantığı, validasyonları ve `ValueNotifier` tanımlarını öğretici yorumlarla oluştur:

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalController sınıfı, aktif kiralama süresini saniye bazında
/// reaktif olarak yönetmek için tasarlanmıştır. Ağır setState kullanmak yerine
/// ValueNotifier tercih edilerek sadece süreyi dinleyen widget'ın yeniden çizilmesi sağlanır.
class ActiveRentalController {
  // Kalan süreyi saniye cinsinden tutan reaktif değişken (Başlangıç: 0)
  final ValueNotifier<int> remainingSeconds = ValueNotifier<int>(0);
  Timer? _timer;

  /// [ÜST AÇIKLAMA]: Kullanıcının seçtiği saat veya gün bilgisini toplam saniyeye çevirip
  /// her saniye 1 azaltan periyodik sayacı başlatır.
  void startCountdown(int totalSeconds) {
    _timer?.cancel();
    remainingSeconds.value = totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value -= 1;
      } else {
        timer.cancel();
      }
    });
  }
  // [ALT AÇIKLAMA]: Timer.periodic her saniye tetiklendiğinde remainingSeconds.value güncellenir
  // ve UI katmanındaki ValueListenableBuilder otomatik olarak yeni saniyeyi ekrana yansıtır.

  /// [ÜST AÇIKLAMA]: Kullanıcı "Aracı Teslim Et" onayını verdiğinde sayacı güvenli şekilde durdurur.
  void stopAndDeliverVehicle() {
    _timer?.cancel();
    remainingSeconds.value = 0;
  }
  // [ALT AÇIKLAMA]: Bellek sızıntısını (memory leak) önlemek için aktif Timer iptal edildi.

  void dispose() {
    _timer?.cancel();
    remainingSeconds.dispose();
  }
}
```

### Adım 3: Model Dosyasını Oluşturma
`models/<feature_name>_model.dart` dosyasını `copyWith`, `fromJson`, `toJson` metotlarını içerecek şekilde `immutable` ve öğretici açıklamalı olarak tanımla:

```dart
/// [ÜST AÇIKLAMA]: VehicleModel, kiralanacak aracın değişmez (immutable) veri modelidir.
/// Tüm alanlar 'final' tanımlanarak veri bütünlüğü korunur.
class VehicleModel {
  final String id;
  final String brandModel;
  final String chassisNo;
  final int modelYear;
  final String usageType; // 'Şahsi' veya 'Ticari'
  final double baseHourlyRate;
  final double baseDailyRate;

  const VehicleModel({
    required this.id,
    required this.brandModel,
    required this.chassisNo,
    required this.modelYear,
    required this.usageType,
    required this.baseHourlyRate,
    required this.baseDailyRate,
  });

  /// [ÜST AÇIKLAMA]: Mevcut nesneyi bozmadan sadece değişen alanlarla yeni bir kopya üretir.
  VehicleModel copyWith({
    String? id,
    String? brandModel,
    String? chassisNo,
    int? modelYear,
    String? usageType,
    double? baseHourlyRate,
    double? baseDailyRate,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      brandModel: brandModel ?? this.brandModel,
      chassisNo: chassisNo ?? this.chassisNo,
      modelYear: modelYear ?? this.modelYear,
      usageType: usageType ?? this.usageType,
      baseHourlyRate: baseHourlyRate ?? this.baseHourlyRate,
      baseDailyRate: baseDailyRate ?? this.baseDailyRate,
    );
  }
  // [ALT AÇIKLAMA]: Null-aware (??) operatörü ile parametre verilmezse eski değer korunur.

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? '',
      brandModel: json['brandModel'] ?? '',
      chassisNo: json['chassisNo'] ?? '',
      modelYear: json['modelYear'] ?? 2024,
      usageType: json['usageType'] ?? 'Şahsi',
      baseHourlyRate: (json['baseHourlyRate'] ?? 0).toDouble(),
      baseDailyRate: (json['baseDailyRate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandModel': brandModel,
      'chassisNo': chassisNo,
      'modelYear': modelYear,
      'usageType': usageType,
      'baseHourlyRate': baseHourlyRate,
      'baseDailyRate': baseDailyRate,
    };
  }
}
// [ALT AÇIKLAMA]: Model sınıfı JSON serileştirme metotları ile yerel/uzak veri kaynaklarına tam uyumludur.
```

### Adım 4: View Dosyasını Oluşturma (Butonlar, Diyaloglar ve Etkileşimler)
`view/<feature_name>_view.dart` dosyasını `const` kurallarına uygun bir `StatelessWidget` olarak tasarla ve diyalog/buton etkileşimlerini öğretici şekilde açıkla:

```dart
import 'package:flutter/material.dart';
import '../controller/active_rental_controller.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalView ekranı StatelessWidget olarak tasarlanmıştır.
/// Çünkü durum yönetimi tamamen ActiveRentalController içindeki ValueNotifier ile yapılır.
class ActiveRentalView extends StatelessWidget {
  final ActiveRentalController controller;
  const ActiveRentalView({super.key, required this.controller});

  /// [ÜST AÇIKLAMA]: Kullanıcı aracı teslim etmek istediğinde yanlışlıkla basmaları önlemek için
  /// Material 3 standartlarında bir AlertDialog (Onay Diyaloğu) açılır.
  Future<void> _showDeliveryConfirmDialog(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Aracı Teslim Et'),
        content: const Text('Kiralama sürenizi sonlandırıp aracı teslim etmek istediğinize emin misiniz?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('İptal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Evet, Teslim Et'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      controller.stopAndDeliverVehicle();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Araç başarıyla teslim edildi. Ana sayfaya yönlendiriliyorsunuz.')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
  // [ALT AÇIKLAMA]: Diyalogdan 'true' dönerse sayaç durdurulur, SnackBar ile geri bildirim verilir ve ilk sayfaya dönülür.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktif Kiralama ve Sayaç')),
      body: ValueListenableBuilder<int>(
        valueListenable: controller.remainingSeconds,
        builder: (context, seconds, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kalan Süre: $seconds sn',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => _showDeliveryConfirmDialog(context),
                  icon: const Icon(Icons.key_off),
                  label: const Text('Aracı Teslim Et'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### Adım 5: Widget Dosyasını Oluşturma
`widget/<feature_name>_card.dart` dosyasında `StatelessWidget` kullanılarak UI katmanını öğretici açıklamalarla oluştur:

```dart
import 'package:flutter/material.dart';

/// [ÜST AÇIKLAMA]: VehicleCard, araç listesindeki her bir öğeyi temsil eden yeniden kullanılabilir
/// (reusable) modüler bir Material 3 kart bileşenidir. 40 satır sınırını korumak için ayrılmıştır.
class VehicleCard extends StatelessWidget {
  final String brandModel;
  final String chassisNo;
  final int modelYear;
  final String usageType;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.brandModel,
    required this.chassisNo,
    required this.modelYear,
    required this.usageType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.directions_car, color: colorScheme.primary),
        title: Text(brandModel, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('Model: $modelYear | Şase: $chassisNo | Tip: $usageType'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: Renkler sabit verilmek yerine Theme.of(context).colorScheme üzerinden alınarak
// karanlık ve aydınlık temaya otomatik uyum sağlaması garanti altına alınmıştır.
```

### Adım 6: Clean Architecture Kurallarına Uyum
- **Separation of Concerns:** Her dosyanın belirli bir sorumluluğu olduğundan emin ol.
- **Reusability:** Widget'ları ve controller'ı diğer ekranlarda da kullanabilecek şekilde tasarla.
- **Testability:** Her katman için ayrı testler yazabileceğinden emin ol.

## Kullanım Örnekleri

### Örnek 1: Basit bir ekran oluşturma
```dart
import 'package:flutter/material.dart';
import '../features/active_rental/controller/active_rental_controller.dart';
import '../features/active_rental/view/active_rental_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ActiveRentalView(controller: ActiveRentalController());
  }
}
```

### Örnek 2: Modüler widget kullanımı
```dart
import 'package:flutter/material.dart';
import '../features/vehicle_catalog/widget/vehicle_catalog_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return VehicleCard(
      brandModel: 'Ford Transit Custom',
      chassisNo: 'WF0XXXTTGX1234567',
      modelYear: 2025,
      usageType: 'Ticari',
      onTap: () {},
    );
  }
}
```

## Ekstra İpuçları
- **Dependency Injection:** Controller'ları widgetlara constructor üzerinden aktar.
- **Navigation:** Ekran geçişlerinde ve geri dönüşlerde Navigator yığınını temiz yönet.
- **Testing:** Her katman için ayrı testler yazarak uygulamanın stabilitesini sağlayabilirsin.

## SSS

### Soru: Hangi durumlarda bu yeteneği kullanmalıyım?
**Cevap:** Yeni bir ekran veya işlev modülü oluştururken bu yeteneği kullanmalısın.

### Soru: Bu yetenek hangi durumlarda kullanmamalıyım?
**Cevap:** Mevcut bir ekranı güncellerken veya küçük bir hata düzeltmesi yaparken bu yeteneği kullanmamalısın.