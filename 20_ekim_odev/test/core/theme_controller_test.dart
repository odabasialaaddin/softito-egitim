import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kirala/core/theme/theme_controller.dart';

/// [ÜST AÇIKLAMA]: ThemeController birim testi, uygulamanın tema modlarının
/// (Sistem, Aydınlık, Karanlık) ValueNotifier üzerinden reaktif olarak
/// doğru şekilde değiştiğini ve döngüsel geçişlerin (toggle) hatasız çalıştığını test eder.
void main() {
  group('ThemeController Tema Yönetimi Birim Testleri', () {
    late ThemeController controller;

    setUp(() {
      controller = ThemeController();
    });

    tearDown(() {
      controller.dispose();
    });

    /// [ÜST AÇIKLAMA]: Başlangıç durumunda tema modunun ThemeMode.system olduğunu doğrular.
    test('Başlangıç tema modu ThemeMode.system olmalıdır', () {
      expect(controller.currentThemeMode, equals(ThemeMode.system));
      expect(controller.themeModeNotifier.value, equals(ThemeMode.system));
    });
    // [ALT AÇIKLAMA]: Varsayılan olarak sistem modu ile başlandığı doğrulandı.

    /// [ÜST AÇIKLAMA]: setThemeMode ile istenen tema modunun doğru atandığını test eder.
    test('setThemeMode ile Aydınlık ve Karanlık moda doğrudan geçilebilmelidir', () {
      controller.setThemeMode(ThemeMode.light);
      expect(controller.currentThemeMode, equals(ThemeMode.light));

      controller.setThemeMode(ThemeMode.dark);
      expect(controller.currentThemeMode, equals(ThemeMode.dark));

      controller.setThemeMode(ThemeMode.system);
      expect(controller.currentThemeMode, equals(ThemeMode.system));
    });
    // [ALT AÇIKLAMA]: Manuel tema seçim fonksiyonunun state üzerindeki etkisi doğrulandı.

    /// [ÜST AÇIKLAMA]: toggleTheme metodunun Sistem -> Aydınlık -> Karanlık -> Sistem sırasını izlediğini test eder.
    test('toggleTheme metodu temaları sırasıyla döngüsel olarak değiştirmelidir', () {
      // 1. Durum: Sistem -> Aydınlık
      controller.toggleTheme();
      expect(controller.currentThemeMode, equals(ThemeMode.light));

      // 2. Durum: Aydınlık -> Karanlık
      controller.toggleTheme();
      expect(controller.currentThemeMode, equals(ThemeMode.dark));

      // 3. Durum: Karanlık -> Sistem
      controller.toggleTheme();
      expect(controller.currentThemeMode, equals(ThemeMode.system));
    });
    // [ALT AÇIKLAMA]: Tek tuşla tema geçiş mantığının eksiksiz çalıştığı onaylandı.
  });
}
// [ALT AÇIKLAMA]: ThemeController testleri, arayüzden bağımsız olarak çekirdek tema durumunu doğrular.
