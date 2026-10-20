import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/core/theme/theme_controller.dart';
import 'package:kirala/main.dart';

/// [ÜST AÇIKLAMA]: widget_test.dart, Kirala uygulamasının ana giriş widget'ı olan
/// KiralaApp'i test eder. Karşılama başlığının, kayıt formunun, butonların ve
/// form validasyon mekanizmasının arayüz seviyesinde (widget test) doğru çalıştığını sınar.
void main() {
  testWidgets('Kirala ana sayfa, form alanları ve validasyon widget testi', (WidgetTester tester) async {
    final themeController = ThemeController();

    // Uygulamayı widget test ortamında ayağa kaldır
    await tester.pumpWidget(KiralaApp(themeController: themeController));
    await tester.pumpAndSettle();

    // 1. Karşılama başlığı ve appBar kontrolleri
    expect(find.text('Kirala • Akıllı Araç'), findsOneWidget);
    expect(find.text('Kayıt ol ve ihtiyacın olan araca ulaş'), findsOneWidget);

    // 2. Form alanlarının ekranda yer aldığını doğrula
    expect(find.text('Ad Soyad'), findsOneWidget);
    expect(find.text('TC Kimlik / Pasaport No'), findsOneWidget);
    expect(find.text('Cep Telefonu'), findsOneWidget);
    expect(find.text('Cinsiyet'), findsOneWidget);

    // 3. Butonların varlığını doğrula
    expect(find.text('Kaydol'), findsOneWidget);
    expect(find.text('Temizle'), findsOneWidget);

    // 4. Form boşken "Kaydol" butonuna tıklandığında validasyon hata mesajlarının tetiklendiğini test et
    await tester.tap(find.text('Kaydol'));
    await tester.pumpAndSettle();

    expect(find.text('Ad Soyad alanı boş bırakılamaz.'), findsOneWidget);
    expect(find.text('TC Kimlik / Pasaport No boş bırakılamaz.'), findsOneWidget);
    expect(find.text('Telefon numarası boş bırakılamaz.'), findsOneWidget);
    expect(find.text('Lütfen bir cinsiyet seçiniz.'), findsOneWidget);

    // 5. Geçerli verileri form alanlarına yaz
    await tester.enterText(find.byKey(const Key('name_input_field')), 'Ahmet Yılmaz');
    await tester.enterText(find.byKey(const Key('identity_input_field')), '12345678901');
    await tester.enterText(find.byKey(const Key('phone_input_field')), '5551234567');

    // Cinsiyet dropdown'ını aç ve seç
    await tester.tap(find.text('Cinsiyet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Erkek').last);
    await tester.pumpAndSettle();

    // 6. Formu tekrar onayla
    await tester.tap(find.text('Kaydol'));
    await tester.pumpAndSettle();

    // Başarı diyaloğunun açıldığını doğrula
    expect(find.text('Kayıt Başarılı'), findsOneWidget);
    expect(find.text('Kaydoldunuz! Araç seçim ekranına yönlendiriliyorsunuz...'), findsOneWidget);

    // Diyalogdaki butona basarak devam et
    await tester.tap(find.text('Araç Seçimine Geç'));
    await tester.pumpAndSettle();

    // 2. Ekranın (Kiralama Kriterleri) açıldığını doğrula
    expect(find.text('Kiralama Kriterleri'), findsOneWidget);
    expect(find.text('Hadi sana uygun aracı seçelim!'), findsOneWidget);
  });
}
// [ALT AÇIKLAMA]: Widget testi, kullanıcı kayıt ve sayfa geçiş akışının
// UI seviyesinde kesintisiz ve hatasız çalıştığını eksiksiz olarak kanıtlar.
