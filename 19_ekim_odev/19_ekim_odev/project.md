# Kan Bağışı ve Grafiksel Stok Takip Uygulaması
Bu doküman Flutter projesinde geliştirme yapacak olan Ajan (AntiGravity) yapay zeka ve yazılım geliştiriciler için bağlayıcı bir kılavuzdur. Projede üretilen her kod satırı buradaki kurallara UYMAK ZORUNDADIR.

## 1. Proje Özeti ve Teknolojiler
- **Uygulama Adı:** CanVer (Akıllı kan bağışı, acil kan talebi ve grafiksel kan stoğu takip uygulaması)
- **Hedef Platformlar:** iOS ve Android öncelikli, ardından web ve masaüstü platformları.
- **Flutter SDK:** 3.15.1
- **Dart SDK:** 3.6.0
- **Tasarım Dili:** Material 3, Çift Tema Desteği (Karanlık Mod / Sistem Teması / Aydınlık Mod; Gece klinik paleti dark crimson & obsidian + Modern medikal aydınlık palet)

## 2. Mimari Yapı: Özellik Bazlı
Kodlar kesinlikle tek bir yerde toplanmayacaktır. Her modül kendi feature klasöründe kodlanacaktır.

```text
lib/
    core/
        constants/app_colors.dart
        extensions/context_extensions.dart
        theme/
            app_theme.dart
            theme_controller.dart
            widget/
                theme_mode_switch_button.dart
    features/
        donation_tracker/
            controller/
            models/
            view/
            widget/
        blood_inventory_chart/
            controller/
            models/
            view/
            widget/
        urgent_requests/
            controller/
            models/
            view/
            widget/
        donation_reminders/
            controller/
            models/
            view/
            widget/
    main.dart
```

#### Sadece uygulama başlatma ve tema bölümleri `main.dart` içinde yer alacaktır.

## 3. Kırmızı Çizgiler ve Kod Kalite Standartları
1 - **State Yönetim Standartları:**
Sayfa düzeyinde ağır `setState` kullanımından kesinlikle kaçın. Sadece yerel arayüz durumunu yöneten (örneğin grafik bar animasyonları, buton tıklama efektleri vb.) `StatefulWidget` kabul edilir.

2 - **UI, Grafik ve Performans Kuralları:** 
Statik tüm widget'larda `const` zorunludur. 
Renk ve metin stilleri kesinlikle tema dosyalarına yazılacaktır.
Büyük `build` metotları yasaktır. 40 satırı geçen `build` metotları (özellikle kan grubu grafik çizimleri ve istatistik kartları) özel widget'lara (`widget/` klasörü altına) ayrılacaktır.

3 - **Harici Paket Yasağı:**
Projeye onay almadan harici ağır state veya grafik paketleri EKLENMEYECEKTİR. Dart'ın ve Flutter'ın yerel çekirdek API'lerini (`ValueNotifier`, `CustomPaint`, `LinearProgressIndicator`, `FractionallySizedBox` vb.) kullanmak esastır.

4 - **Sistem Karanlık Mod ve Tema Standartları:**
Tema yönetimi `core/theme/theme_controller.dart` içinde `ValueNotifier<ThemeMode>` ile reaktif olarak yönetilir. `ThemeMode.system`, `ThemeMode.dark` ve `ThemeMode.light` durumları desteklenir. Cihaz sistem modu ile tam senkronize çalışır; istenirse kullanıcı manuel olarak da karanlık/aydınlık moda geçebilir. Doğrudan sabit renkler yerine `Theme.of(context).colorScheme` ve tema tokens kullanılmalıdır.

## 4. Geliştirme, Analiz ve Test Komutları
Ajan yaptığı herhangi bir kod değişikliğinden sonra mutlaka alttaki komutların çalıştığını doğrulamalıdır.

- **Statik kod analizi (0 uyarı ve 0 hata şart):**
```bash
flutter analyze
```
- **Birim ve widget testleri:** 
```bash
flutter test
```
- **Projeyi çalıştırma:**
```bash
flutter run
```

## 5. Ajanın Çıktı ve Yanıt Verme Standartları
**Açıklamalar:** Türkçe teknik terimlerin özünü bozmadan net ve doğrudan olacaktır.

**Değişiklik Sunumları:** Örnek 500 satırlık bir dosyada 3 satır değiştiyse tüm dosyayı baştan sona basma; hedef satırları ve diff yapısını göster.

**Dosya Yolları:** Bahsedilen ve üretilen her dosya için mutlaka projeye göre tıklanabilir link ver.

**Doğrulama:** Kod yazdıktan sonra kullanıcıya "Şimdi Flutter analiz ile kontrol edebilirsin." şeklinde doğrulama yönergeleri ver.