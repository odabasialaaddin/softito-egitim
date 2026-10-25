import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Arka Plan Paleti (Hafif Krem / Tam Beyaz Olmayan Sıcak Kırık Beyaz)
  static const Color creamBackground = Color(0xFFFAF8F5);
  static const Color creamBackgroundDark = Color(0xFF1A1A1E);
  static const Color earthPrimary = Color(0xFF1E3A5F); // Derin Lacivert/Mavi ton
  static const Color earthLight = Color(0xFFFAF8F5); // Krem Arka Plan
  static const Color earthDark = Color(0xFF152A42);
  static const Color earthDarkObsidian = Color(0xFF121820);

  // Buton Paleti (Gradient Mavi)
  static const Color blueGradientStart = Color(0xFF1565C0); // Derin Kurumsal Mavi
  static const Color blueGradientEnd = Color(0xFF0288D1); // Canlı Okyanus Mavisi
  static const Color blueAccent = Color(0xFF00ACC1);

  static const LinearGradient blueGradient = LinearGradient(
    colors: [blueGradientStart, blueGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradientHover = LinearGradient(
    colors: [Color(0xFF0D47A1), Color(0xFF0277BD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Eski referansların uyumluluğu için buton ana rengi
  static const Color grassGreen = Color(0xFF1565C0);
  static const Color grassGreenLight = Color(0xFF42A5F5);
  static const Color grassGreenDark = Color(0xFF0D47A1);

  // Çok Açık Gökyüzü Mavisi (Kartlar, Kutucuklar, Input Alanları)
  static const Color skyBlueLight = Color(0xFFF0F8FF); // Çok açık ferah gökyüzü mavisi
  static const Color skyBlueMedium = Color(0xFFE1F5FE);
  static const Color skyBlueDark = Color(0xFF1A2634);
  static const Color skyBlueInputFillDark = Color(0xFF223040);

  // Nötr ve Yardımcı Renkler
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);
  static const Color textDark = Color(0xFF1C2530);
  static const Color textLight = Color(0xFFF5F5F5);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFCFD8DC);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);
  static const Color success = Color(0xFF2E7D32);
  static const Color chipBackground = Color(0xFFE1F5FE);
}
