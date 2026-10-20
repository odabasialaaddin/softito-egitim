import 'package:flutter/material.dart';

/// BuildContext üzerinde tema ve ekran boyutlarına kolay erişim sağlayan extension.
extension ContextExtensions on BuildContext {
  /// Aktif ThemeData
  ThemeData get theme => Theme.of(this);

  /// Aktif ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Aktif TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Ekran genişliği
  double get width => MediaQuery.sizeOf(this).width;

  /// Ekran yüksekliği
  double get height => MediaQuery.sizeOf(this).height;

  /// Cihazın veya aktif temanın karanlık modda olup olmadığı
  bool get isDarkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}
