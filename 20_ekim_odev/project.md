# Akıllı Araç Kiralama ve Canlı Takip Uygulaması
Bu doküman Flutter projesinde geliştirme yapacak olan Ajan (AntiGravity) yapay zeka ve yazılım geliştiriciler için bağlayıcı bir kılavuzdur. Projede üretilen her kod satırı buradaki kurallara UYMAK ZORUNDADIR.

## 1. Proje Özeti ve Teknolojiler
- **Uygulama Adı:** Kirala (Akıllı araç filtreleme, dinamik fiyat hesaplama ve canlı kiralama süresi takip uygulaması)
- **Hedef Platformlar:** IOS ve Android öncelikli ardından web ve masaüstü platformları.
- **Flutter SDK:** 3.15.1
- **Dart SDK:** 3.6.0
- **Tasarım Dili:** Material 3, Çift Tema Desteği (Karanlık Mod / Sistem Teması / Aydınlık Mod; Otomotiv asfalt grisi & elektrik mavisi/kehribar vurgu paleti dark asphalt & electric blue + Modern aydınlık palet)

## 2. Mimari Yapı: Özellik bazlı
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
        auth_register/
            controller/
            models/
            view/
            widget/
        vehicle_filter/
            controller/
            models/
            view/
            widget/
        vehicle_catalog/
            controller/
            models/
            view/
            widget/
        active_rental/
            controller/
            models/
            view/
            widget/
    main.dart
```

#### Sadece uygulama başlatma ve tema bölümleri

## 3. Kırmızı Çizgiler Kod Kalite ve Pedagojik Standartlar
1 - **State Yönetim Standartları:**
Sayfa düzeyinde ağır `setState` kullanımından kesinlikle kaçın. Sadece yerel arayüz durumunu yöneten (örneğin buton animasyonları vb.) StatefulWidget kabul edilir. Tüm form, filtre, fiyat hesaplama ve canlı geri sayım (Timer) durumları `ValueNotifier` ile yönetilecektir.

2 - **UI ve Performans Kuralları:** 
Statik tüm widget'larda `const` zorunludur. 
Renk ve metin stilleri kesinlikle tema dosyalarına yazılacaktır.
Büyük build metotları yasaktır. 40 satırı geçen build metotları özel widgetlara yazılacaktır. 

3 - **Paket Standartları:**
Projeye onay almadan harici ağır state paketleri EKLENMEYECEKTİR. Dart'ın ve Flutter'ın yerel çekirdek apilerini (`ValueNotifier`, `ValueListenableBuilder`, `Timer`, `Form`, `GlobalKey<FormState>`) kullanmak esastır. 

4 - **Sistem Karanlık Mod ve Material Design 3 Tema Standartları:**
Tema yönetimi `core/theme/theme_controller.dart` içinde `ValueNotifier<ThemeMode>` ile reaktif olarak yönetilir. `ThemeMode.system`, `ThemeMode.dark` ve `ThemeMode.light` durumları desteklenir. Cihaz sistem modu ile tam senkronize çalışır; istenirse kullanıcı manuel olarak da karanlık/aydınlık moda geçebilir. Doğrudan sabit renkler yerine `Theme.of(context).colorScheme` ve Material 3 tema tokens kullanılmalıdır.

5 - **Zorunlu Teknik Kapsam (UI, Form, Validasyon ve Diyaloglar):**
- **Temel UI Elemanları, Butonlar & Etkileşimler:** Material 3 standartlarında `FilledButton`, `OutlinedButton`, `ElevatedButton`, `IconButton`, `SegmentedButton`, `Card`, `ListTile`, `Chip` ve `InkWell` bileşenleri aktif kullanılmalıdır.
- **Form Yönetimi, Validasyonlar & Kullanıcı Girişi:** `Form`, `GlobalKey<FormState>`, `TextFormField`, `DropdownButtonFormField`, `InputDecoration`, `TextInputType`, `maxLength` ve özel `validator` fonksiyonları (11 hane TC/Pasaport, 10 hane Telefon, boş alan ve pozitif sayı kontrolü) eksiksiz uygulanmalıdır.
- **Diyaloglar ve Bildirimler:** Kullanıcı etkileşimlerinde `showDialog` (`AlertDialog` ile kiralama onayı ve araç teslim onayı), `showModalBottomSheet` (saatlik/günlük maliyet hesaplama penceresi) ve `ScaffoldMessenger` (`SnackBar` bilgilendirmeleri) zorunlu olarak kullanılmalıdır.

6 - **Öğretici Açıklama Satırları Zorunluluğu (Pedagojik Kodlama):**
Üretilen her dosyada; sınıfların, metotların, widget'ların ve kritik kod bloklarının **hem üstünde hem de altında** kodun ne iş yaptığını, neden o yapının seçildiğini ve çalışma mantığını anlatan **detaylı, öğretici Türkçe yorum satırları (`///` veya `//`)** bulunmak ZORUNDADIR. Yorum satırları sadece ne olduğunu değil, *mantığını* öğretmelidir.

## 4. Geliştirme Analiz ve Test Komutları
Ajan yaptığı herhangi bir kod değişikliklerinden sonra mutlaka alttaki komutların çalıştığını doğrulamalıdır. 

- **Statik kod analizi(0 uyarı ve 0 hata şart):**
```bash
flutter analyze
```
- **Birim ve widget testleri:** 
```bash
flutter test
```
- **Projeyi iOS Simülatörde çalıştırma:**
```bash
open -a Simulator && flutter run -d ios
```

## 5. Ajanın Çıktı ve Yanıt Verme Standartları
**Açıklamalar:** Türkçe teknik terimlerin özünü bozmadan net, doğrudan ve öğretici olacaktır.

**Değişiklik Sunumları:** Örnek 500 satırlık bir dosyada 3 satır değiştiyse tüm dosyayı baştan sona basma; hedef satırları ve diff yapısını göster. 

**Dosya Yolları:** Bahsedilen ve üretilen her dosya için mutlaka projeye göre tıklanabilir link ver.

**Doğrulama:** Kod yazdıktan sonra kullanıcıya "Şimdi Flutter analiz ile kontrol edebilirsin." şeklinde doğrulama yönergeleri ver.