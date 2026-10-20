import 'package:flutter/material.dart';

/// [ÜST AÇIKLAMA]: BuildContextExtensions, Flutter'ın BuildContext nesnesi üzerine
/// sık kullanılan tema, renk, tipografi ve ekran boyutlarına tek satırda ve okunabilir
/// şekilde erişebilmek için yazılmış pratik uzantı (extension) sınıfıdır.
/// 'Theme.of(context).colorScheme' gibi uzun kodlar yerine 'context.colorScheme' yazımını mümkün kılar.
extension BuildContextExtensions on BuildContext {
  /// [ÜST AÇIKLAMA]: Aktif ThemeData nesnesine hızlı ve temiz erişim sağlar.
  ThemeData get theme => Theme.of(this);
  // [ALT AÇIKLAMA]: Widget ağacındaki en yakın ThemeData örneğini döndürür.

  /// [ÜST AÇIKLAMA]: Material 3 ColorScheme renk belirteçlerine (tokens) doğrudan erişim sunar.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  // [ALT AÇIKLAMA]: Sabit renk kullanımını önleyip aktif temanın renk paletine erişimi standartlaştırır.

  /// [ÜST AÇIKLAMA]: Material 3 TextTheme tipografi kurallarına doğrudan erişim sağlar.
  TextTheme get textTheme => Theme.of(this).textTheme;
  // [ALT AÇIKLAMA]: Başlık, gövde ve etiket yazı tiplerini merkezi temadan çekmeyi kolaylaştırır.

  /// [ÜST AÇIKLAMA]: Cihazın ekran boyutunu MediaQuery üzerinden okur.
  Size get screenSize => MediaQuery.sizeOf(this);
  // [ALT AÇIKLAMA]: MediaQuery.sizeOf metodu ile gereksiz rebuild'lerin önüne geçilir.

  /// [ÜST AÇIKLAMA]: Ekran genişliğini piksel cinsinden döndürür.
  double get screenWidth => screenSize.width;
  // [ALT AÇIKLAMA]: Responsive (duyarlı) tasarım kurallarında ekran genişliği kıyaslamasını basitleştirir.

  /// [ÜST AÇIKLAMA]: Ekran yüksekliğini piksel cinsinden döndürür.
  double get screenHeight => screenSize.height;
  // [ALT AÇIKLAMA]: Dikey kaydırma veya modal yükseklik hesaplamalarında kullanılır.

  /// [ÜST AÇIKLAMA]: Çentik ve sistem çubuğu boşluklarını (safe area padding) verir.
  EdgeInsets get systemPadding => MediaQuery.paddingOf(this);
  // [ALT AÇIKLAMA]: Cihazın durum çubuğu ve alt navigasyon çubuğu boşluklarına güvenli erişim sağlar.
}
// [ALT AÇIKLAMA]: BuildContextExtensions uzantısı sayesinde kod tekrarı (boilerplate) azaltılır,
// kod tabanı çok daha temiz, modern ve okunabilir hale gelir.
