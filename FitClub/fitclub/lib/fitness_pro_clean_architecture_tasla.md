# Fitness Pro - Sektör Standardı Clean Architecture Taslağı (Nihai Vizyon)

Bu taslak, 60 Günlük İleri Seviye Flutter Mühendislik Kampı müfredatındaki (Faz 1, 2, 3 ve 4) ileri düzey konuların (Isolate, Hive, CustomPainter, bloc_concurrency, GoRouter, MethodChannel, Unit Test) alt sekmeli, modern bir "Fitness & Kalori Takip" uygulamasına entegre edilmiş halidir. 

## 1. GÜN: Çekirdek Omurga (`core`) + Canlı Aramalı Egzersiz Kütüphanesi (`workout`)

**Hedef:** İnternet olsa da olmasa da çalışan, devasa JSON verisini ana thread'i dondurmadan işleyen ve anında filtrelenebilen bağımsız kütüphane modülü.
**Kullanılacak API:** Free Exercise DB (GitHub Raw JSON)
**Arayüz Vizyonu:** İleride `go_router` ile 3. sekmeye yerleşecek olan, üstünde akıcı bir arama çubuğu barındıran Egzersiz Kütüphanesi sayfası.

**Uygulanacak Mühendislik Konuları:**
- **Ağ Katmanı:** `Dio`, `QueuedInterceptorsWrapper` ve `fpdart` (`Either<Failure, T>`)
- **Bağımlılık Enjeksiyonu (DI):** `get_it`
- **Modelleme:** `freezed`, `json_serializable` ve Entity-Model Mapper yapıları (Nullable alanlar ve güvenli parse).
- **Multithreading:** `Isolate.run()` ile 800+ egzersiz JSON verisini arka çekirdekte parse etme.
- **Offline-First:** `Hive` veya `Drift` ile yerel önbellekleme (Single Source of Truth).
- **Performanslı UI & State:** `SliverList`, `ValueKey` ile akıcı kaydırma, bellek dostu arama mantığı ve `WorkoutCubit` (Freezed Union States) ile state yönetimi.

**Yazılacak Dosya Sırası:**
1. `pubspec.yaml` (Kurulum)
2. `core/error/failures.dart`
3. `core/network/network_client.dart`
4. `features/workout/domain/entities/exercise_entity.dart`
5. `features/workout/data/models/exercise_model.dart`
6. `features/workout/data/datasources/workout_datasource.dart` (Isolate + Hive)
7. `features/workout/domain/repositories/workout_repository.dart`
8. `features/workout/presentation/bloc/workout_cubit.dart`
9. `features/workout/presentation/pages/workout_page.dart`

---

## 2. GÜN: Beslenme, Barkod Modülü (`nutrition`)

**Hedef:** Canlı besin araması yapan, kameradan barkod okuyan ve besin makrolarını çeken bağımsız modül.
**Kullanılacak API:** Open Food Facts API
**Arayüz Vizyonu:** 2. sekmede yer alacak olan; barkod okuyucu kamera arayüzü ve manuel arama çubuğu içeren besin kayıt merkezi.

**Uygulanacak Mühendislik Konuları:**
- **BLoC Concurrency:** Arama kutusunda 300ms `debounce` ve `restartable()` ile gereksiz API isteklerini önleme.
- **Bellek Yönetimi:** Kamera stream'leri ve `TextEditingController` için lifecycle (dispose) yönetimi.

**Yazılacak Dosya Sırası:**
1. `food_entity.dart` & `food_model.dart`
2. `nutrition_datasource.dart` & `nutrition_repository.dart` (Pagination)
3. `nutrition_bloc.dart` (Event-Driven + Debounce)
4. `nutrition_page.dart`

---

## 3. GÜN: Native Sensör, 60 FPS Özet Paneli (`dashboard`) ve Kurumsal Kapanış

**Hedef:** Adım verisi çekmek, kalori halkası çizmek, testleri yazmak ve bağımsız yazılan 3 modülü kurumsal navigasyon ile birleştirmek.
**Kullanılacak API:** Yok (Yerel sensörler kullanılacak).
**Arayüz Vizyonu:** Uygulamanın ana ekranı (1. sekme). Ortasında 60 FPS kalori ve adım halkası barındıran, alt navigasyon çubuğuyla (BottomNavigationBar) diğer modüllere state kaybetmeden geçiş sağlayan modern panel.

**Uygulanacak Mühendislik Konuları:**
- **Native Köprü:** `MethodChannel` ve `EventChannel` ile cihaz pedometre sensöründen Flutter'a canlı stream akışı.
- **İleri Seviye UI:** Hazır paket KULLANMADAN `CustomPainter`, `AnimationController` ve `RepaintBoundary` ile kalori/adım halkası (Donut Chart) çizimi.
- **State Optimizasyonu:** Gelen sensör stream'ini dinlerken `Equatable` kullanarak ekranda gereksiz rebuild'leri önleme.
- **Kurumsal Navigasyon:** `go_router` (`StatefulShellRoute`) ile state kaybetmeyen alt sekmeler oluşturma.
- **Yazılım Testleri:** `mocktail` ve `bloc_test` ile Unit/BLoC testleri yazımı (%70+ Coverage hedefi).

**Yazılacak Dosya Sırası:**
1. `native_sensor_service.dart` & Platform Native Kodları (Kotlin/Swift)
2. `dashboard_cubit.dart` (Stream dinleme)
3. `calorie_ring_painter.dart` (CustomPainter Widget)
4. `dashboard_page.dart`
5. `app_router.dart` & `injection_container.dart` (go_router + get_it)
6. `test/workout_cubit_test.dart` (Birim testleri)