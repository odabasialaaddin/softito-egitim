### agent.md
```markdown
# Ders Programı Düzenleyici - Ajan (AntiGravity) Kılavuzu

Bu doküman Flutter projesinde geliştirme yapacak olan Ajan (AntiGravity) yapay zeka ve yazılım geliştiriciler için bağlayıcı bir kılavuzdur. Projede üretilen her kod satırı buradaki kurallara **UYMAK ZORUNDADIR**.

## 1. Proje Özeti ve Teknolojiler
- **Uygulama Adı:** Ders Programı Düzenleyici (Akademik Takip, Planlama ve İletişim Uygulaması)
- **Hedef Platformlar:** iOS dan Android öncelikli, ardından Web ve Masaüstü platformları.
- **Flutter SDK:** 3.15.1
- **Dart SDK:** 3.6.0
- **Tasarım Dili:** Material 3, Çift Tema Desteği (Karanlık Mod / Sistem Teması / Aydınlık Mod) + Kurumsal Palet:
  - Arka Plan: Toprak Rengi (`#8D6E63` / `#D7CCC8`)
  - Butonlar: Çim Yeşili (`#4CAF50`)
  - Kutucuklar ve Kartlar: Çok Açık Gökyüzü Mavisi (`#E1F5FE`)

## 2. Mimari Yapı: Özellik Bazlı (Feature-First)
Kodlar kesinlikle tek bir yerde toplanmayacaktır. Her modül kendi `feature` klasöründe kodlanacaktır. `main.dart` dosyası **sadece** uygulama başlatma ve tema tanımlama bölümlerini içerecektir.

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
        auth/
            controller/
            models/
            view/
            widget/
        schedule/
            controller/
            models/
            view/
            widget/
        study_plan/
            controller/
            models/
            view/
            widget/
        todo/
            controller/
            models/
            view/
            widget/
        exam_calendar/
            controller/
            models/
            view/
            widget/
        communication/
            controller/
            models/
            view/
            widget/
    main.dart
3. Kırmızı Çizgiler ve Kod Kalite Standartları
State Yönetim Standartları:
Sayfa düzeyinde ağır setState kullanımından kesinlikle kaçın.
Tüm iş mantığı ve durum yönetimi ilgili modülün controller/ klasöründeki sınıflarda ValueNotifier<T> ile yapılacaktır.
UI katmanında (view/ ve widget/) durum dinleme işlemi ValueListenableBuilder ile gerçekleştirilecektir.
Sadece yerel arayüz durumunu yöneten (örneğin küçük animasyonlar veya TextEditingController dispose işlemleri) StatefulWidget kullanımına izin verilir.
UI ve Performans Kuralları:
Statik tüm widget'larda const kullanımı zorunludur.
Renk ve metin stilleri kesinlikle core/constants/app_colors.dart ve core/theme/app_theme.dart dosyalarına yazılacaktır. UI içinde hardcoded renk kullanılmayacaktır.
Büyük build metotları yasaktır! 40 satırı geçen build metotları derhal parçalanarak modülün widget/ klasörüne özel widget olarak yazılacaktır.
Paket Kısıtlaması:
Projeye onay almadan harici ağır state veya UI paketleri EKLENMEYECEKTİR.
Dart'ın ve Flutter'ın yerel çekirdek API'lerini (flutter/material.dart, flutter/foundation.dart) kullanmak esastır.
Sistem Karanlık Mod ve Tema Standartları:
Tema yönetimi core/theme/theme_controller.dart içinde ValueNotifier<ThemeMode> ile reaktif olarak yönetilir.
ThemeMode.system, ThemeMode.dark ve ThemeMode.light durumları desteklenir.
app_theme.dart içerisinde Toprak Rengi arka plan, Çim Yeşili butonlar ve Gökyüzü Mavisi kart/kutucuk kuralları ThemeData ve ColorScheme olarak tanımlanmalıdır.
İş Kuralları (Business Logic) Kırmızı Çizgileri:
Giriş ekranında Atatürk'ün "Hayatta en hakiki mürşit ilimdir." sözü ve "K. Atatürk" imzası özel bir widget (AtaturkQuoteBanner) olarak en üstte yer almalıdır.
Varsayılan giriş bilgisi (id: user, şifre: 123456) AuthController içinde doğrulanmalıdır.
ScheduleController içinde ders eklenirken gün ve saat çakışması varsa ekleme reddedilmeli ve UI'a hata durumu bildirilmelidir.
Öğretmen ve Öğrenci rol ayrımları (UserRole.teacher, UserRole.student) tüm sayfalarda sıkı şekilde kontrol edilmeli; öğrenci giriş yaptığında ders programı ve sınav takvimi düzenleme araçları kesinlikle gizlenmelidir.
4. Geliştirme Analiz ve Test Komutları
Ajan yaptığı herhangi bir kod değişikliğinden sonra mutlaka alttaki komutların çalıştığını doğrulamalıdır:
Statik kod analizi (0 uyarı ve 0 hata şart):
Bash
flutter analyze
Birim ve widget testleri:
Bash
flutter test
Projeyi çalıştırma:
Bash
flutter run
5. Ajanın Çıktı ve Yanıt Verme Standartları
Açıklamalar: Türkçe, teknik terimlerin özünü bozmadan net ve doğrudan olacaktır.
Değişiklik Sunumları: Örnek 500 satırlık bir dosyada 3 satır değiştiyse tüm dosyayı baştan sona basma; hedef satırları ve diff yapısını göster.
Dosya Yolları: Bahsedilen ve üretilen her dosya için mutlaka projeye göre tıklanabilir link veya tam dizin yolu ver.
Doğrulama: Kod yazdıktan sonra kullanıcıya "Şimdi flutter analyze ile kontrol edebilirsin." şeklinde doğrulama yönergeleri ver.