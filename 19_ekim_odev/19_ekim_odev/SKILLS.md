name:flutter-feature-scaffold
description:Flutter projelerinde feature bazlı kan bağışı ve grafik modülleri yazmak için gerekli klasör yapısını oluşturur. ValueNotifier state mimarisini, grafiksel UI ayrımını ve birim test iskeletini standartlara uygun olarak üretir.

# Flutter Feature Scaffold (Modüler Ekran ve Grafik İskeleti)
Bu yetenek, projede yeni bir ekran ya da grafiksel işlev modülü açarken Clean UI ve reaktif state kurallarına tam uyulmasını garanti altına alır.

## Temel Kurallar
1. **Asla tek dosyada toplama:** UI (`_view.dart`), State controller (`_controller.dart`), model (`_model.dart`) ve grafik/kart bileşenleri (`_chart_card.dart`) ayrı ayrı açılmalıdır.
2. **State Yönetimi:** Basit ve reaktif durumlar (kan stoğu değişimi, bağış sayısı artışı ve grafik güncellemeleri) için `ValueNotifier` kullanılmalıdır. Doğrudan devasa `StatefulWidget` yazarak işi karmaşıklaştırma.
3. **const Zorunluluğu:** Mümkün olan tüm widget'larda `const` olmalıdır.

## Adım Adım Uygulama Akışı

### Adım 1: Klasör Yapısını Oluşturma
Hedeflenen modül adlarını (örn: `blood_inventory_chart`), `lib/features/<feature_name>` altına kur:

```text
lib/features/<feature_name>/
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
`controller/<feature_name>_controller.dart` içinde mantığı ve `ValueNotifier` tanımlarını oluştur:

```dart
import 'package:flutter/foundation.dart';

class DonationTrackerController {
  final ValueNotifier<int> currentDonatedUnits = ValueNotifier<int>(0);
  final int targetUnits = 100; // Hedeflenen 100 ünite kan stoğu

  void addDonation() {
    if (currentDonatedUnits.value < targetUnits) {
      currentDonatedUnits.value += 1;
    }
  }

  void resetDonations() {
    currentDonatedUnits.value = 0;
  }

  void dispose() {
    currentDonatedUnits.dispose();
  }
}
```

### Adım 3: Model Dosyasını Oluşturma
`models/<feature_name>_model.dart` dosyasını `copyWith`, `fromJson`, `toJson` metotlarını içerecek şekilde `immutable` olarak tanımla:

```dart
class DonorProfile {
  final String name;
  final String bloodType;
  final String profileImage;
  final int donationCount;
  final int healthPoints;

  const DonorProfile({
    required this.name,
    required this.bloodType,
    required this.profileImage,
    required this.donationCount,
    required this.healthPoints,
  });

  DonorProfile copyWith({
    String? name,
    String? bloodType,
    String? profileImage,
    int? donationCount,
    int? healthPoints,
  }) {
    return DonorProfile(
      name: name ?? this.name,
      bloodType: bloodType ?? this.bloodType,
      profileImage: profileImage ?? this.profileImage,
      donationCount: donationCount ?? this.donationCount,
      healthPoints: healthPoints ?? this.healthPoints,
    );
  }

  factory DonorProfile.fromJson(Map<String, dynamic> json) {
    return DonorProfile(
      name: json['name'] ?? '',
      bloodType: json['bloodType'] ?? '',
      profileImage: json['profileImage'] ?? '',
      donationCount: json['donationCount'] ?? 0,
      healthPoints: json['healthPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bloodType': bloodType,
      'profileImage': profileImage,
      'donationCount': donationCount,
      'healthPoints': healthPoints,
    };
  }
}
```

### Adım 4: View Dosyasını Oluşturma
`view/<feature_name>_view.dart` dosyasını `StatelessWidget` olarak tasarla ve grafiksel doluluk oranını `ValueListenableBuilder` ile dinle:

```dart
import 'package:flutter/material.dart';
import '../controller/donation_tracker_controller.dart';
import '../widget/donation_tracker_card.dart';

class DonationTrackerView extends StatelessWidget {
  final DonationTrackerController _controller = DonationTrackerController();

  DonationTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kan Bağışı ve Stok Grafiği'),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _controller.currentDonatedUnits,
        builder: (context, currentUnits, _) {
          final double fillRatio = currentUnits / _controller.targetUnits;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DonationTrackerCard(
                  title: 'A Rh+ Kan Stoğu Grafiği',
                  subtitle: 'Hedef: ${_controller.targetUnits} Ünite',
                  bloodType: 'A Rh+',
                  currentUnits: currentUnits,
                  fillRatio: fillRatio,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _controller.addDonation,
                  child: const Text('1 Ünite Kan Bağışı Ekle'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _controller.resetDonations,
                  child: const Text('Stoğu Sıfırla'),
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

### Adım 5: Grafiksel Widget Dosyasını Oluşturma
`widget/<feature_name>_card.dart` dosyasında `StatelessWidget` kullanarak yerel Flutter bar/doluluk grafiğini içeren UI katmanını oluştur (40 satır sınırını aşmamak için grafik bu alt bileşende tutulur):

```dart
import 'package:flutter/material.dart';

class DonationTrackerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String bloodType;
  final int currentUnits;
  final double fillRatio;

  const DonationTrackerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.bloodType,
    required this.currentUnits,
    required this.fillRatio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: fillRatio.clamp(0.0, 1.0),
              minHeight: 16,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),
            Text('$bloodType Mevcut Stok: $currentUnits Ünite (\%${(fillRatio * 100).toInt()})'),
          ],
        ),
      ),
    );
  }
}
```

### Adım 6: Clean Architecture Kurallarına Uyum
- **Separation of Concerns:** Her dosyanın belirli bir sorumluluğu olduğundan emin ol.
- **Reusability:** Grafik widget'larını ve controller'ı diğer ekranlarda da kullanabilecek şekilde tasarla.
- **Testability:** Her katman için ayrı testler yazabileceğinden emin ol.

## Kullanım Örnekleri

### Örnek 1: Basit bir ekran oluşturma
```dart
import 'package:flutter/material.dart';
import '../features/donation_tracker/view/donation_tracker_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DonationTrackerView();
  }
}
```

### Örnek 2: Modüler grafik kartı kullanımı
```dart
import 'package:flutter/material.dart';
import '../features/donation_tracker/widget/donation_tracker_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DonationTrackerCard(
      title: 'Genel Kan Stoğu',
      subtitle: 'Günlük Bağış Oranı',
      bloodType: '0 Rh-',
      currentUnits: 45,
      fillRatio: 0.45,
    );
  }
}
```

## Ekstra İpuçları
- **Dependency Injection:** Controller'ları widget'lara inject etmek için GetIt veya Provider kullanabilirsin.
- **Navigation:** Navigasyonu sağlamak için Navigator 2.0 veya go_router kullanabilirsin.
- **Testing:** Her katman için ayrı testler yazarak uygulamanın stabilitesini sağlayabilirsin.

## SSS

### Soru: Hangi durumlarda bu yeteneği kullanmalıyım?
**Cevap:** Yeni bir ekran, kan bağışı modülü veya grafiksel stok takip bileşeni oluştururken bu yeteneği kullanmalısın.

### Soru: Bu yeteneği hangi durumlarda kullanmamalıyım?
**Cevap:** Mevcut bir ekranı güncellerken veya küçük bir hata düzeltmesi yaparken bu yeteneği kullanmamalısın.