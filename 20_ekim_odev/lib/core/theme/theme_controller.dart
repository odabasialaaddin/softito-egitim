import 'package:flutter/material.dart';

/// [ÜST AÇIKLAMA]: ThemeController sınıfı, uygulamanın tema modunu (Sistem / Aydınlık / Karanlık)
/// harici bir state yönetim paketine (Bloc/Provider/Riverpod) ihtiyaç duymadan,
/// Flutter'ın yerel ve hafif ValueNotifier yapısıyla reaktif olarak yönetir.
/// Bu sayede tema değiştiğinde yalnızca dinleyen MaterialApp yeniden inşa edilir.
class ThemeController {
  /// Tema modunu tutan ve dinleyicileri reaktif olarak haberdar eden ValueNotifier örneği.
  /// Varsayılan olarak kullanıcının cihaz ayarlarını takip eden ThemeMode.system ile başlar.
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  /// [ÜST AÇIKLAMA]: Aktif tema modunu okumak için kullanılan getter özelliği.
  ThemeMode get currentThemeMode => themeModeNotifier.value;
  // [ALT AÇIKLAMA]: ValueNotifier'ın içindeki anlık ThemeMode değerini doğrudan döndürür.

  /// [ÜST AÇIKLAMA]: Temayı kullanıcının seçtiği yeni moda ayarlar.
  void setThemeMode(ThemeMode mode) {
    if (themeModeNotifier.value != mode) {
      themeModeNotifier.value = mode;
    }
  }
  // [ALT AÇIKLAMA]: Aynı mod tekrar seçildiğinde gereksiz bildirim göndermeyi önler (optimizasyon).

  /// [ÜST AÇIKLAMA]: Tek tuşla temalar arasında döngüsel geçiş (Sistem -> Aydınlık -> Karanlık -> Sistem) sağlar.
  void toggleTheme() {
    switch (themeModeNotifier.value) {
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
    }
  }
  // [ALT AÇIKLAMA]: Hızlı tema geçişi için kullanıcı dostu bir döngü mantığı sunar.

  /// [ÜST AÇIKLAMA]: Controller ömrünü tamamladığında bellek sızıntısını önlemek için ValueNotifier'ı serbest bırakır.
  void dispose() {
    themeModeNotifier.dispose();
  }
  // [ALT AÇIKLAMA]: ValueNotifier dinleyicilerini temizleyerek belleğin güvenle boşaltılmasını sağlar.
}
// [ALT AÇIKLAMA]: ThemeController, Clean Architecture prensiplerine uygun, test edilebilir ve
// bağımsız bir tema durum yöneticisi olarak görev yapar.
