import 'package:flutter/material.dart';

/// [ÜST AÇIKLAMA]: AppColors sınıfı, "Kirala" akıllı araç kiralama uygulaması için
/// otomotiv asfalt grisi (dark asphalt), elektrik mavisi (electric blue) ve kehribar (amber)
/// vurgu renklerini merkezi ve tutarlı bir şekilde yöneten sabit renk paletidir.
/// Sabit renk kodları doğrudan arayüz widget'larına gömülmek yerine burada tanımlanır
/// ve Material 3 ColorScheme üzerinden temaya aktarılır.
class AppColors {
  // Özel kurucu (private constructor) ile bu sınıftan nesne üretilmesi engellenir.
  AppColors._();

  // --- KARANLIK MOD (DARK ASPHALT & ELECTRIC BLUE) PALETİ ---
  /// Asfalt Siyahı: Karanlık modun en derin arka plan rengi
  static const Color darkBackground = Color(0xFF0F141C);

  /// Asfalt Yüzey Grisi: Kartlar ve paneller için kullanılan koyu asfalt tonu
  static const Color darkSurface = Color(0xFF18202A);

  /// Koyu Kart Rengi: Ayrılmış bileşenler ve modal pencereler için yüzey tonu
  static const Color darkCard = Color(0xFF222C38);

  /// Elektrik Mavisi: Modern elektrikli araçları simgeleyen canlı birincil vurgu rengi
  static const Color electricBlue = Color(0xFF00D2FF);

  /// Derin Elektrik Mavisi: Buton ve etkileşimli alanlar için doygun mavi
  static const Color electricBlueDark = Color(0xFF0099CC);

  /// Kehribar (Amber): Dikkat çekici rozetler, ticari araç vurguları ve ikazlar için
  static const Color amberAccent = Color(0xFFFFB300);

  /// Karanlık mod kenarlık ve çizgi rengi
  static const Color darkBorder = Color(0xFF2C3947);

  // --- AYDINLIK MOD (LIGHT MODERN SLATE) PALETİ ---
  /// Aydınlık Arka Plan: Gözü yormayan açık gri-mavi slate tonu
  static const Color lightBackground = Color(0xFFF6F8FB);

  /// Aydınlık Yüzey: Kartlar ve formlar için temiz beyaz yüzey
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Aydınlık Kart Rengi: İnce kontrastlı kart dolgusu
  static const Color lightCard = Color(0xFFEDF2F7);

  /// Aydınlık Birincil Mavi: Açık temada yüksek kontrast sağlayan safir mavi
  static const Color lightPrimaryBlue = Color(0xFF0284C7);

  /// Aydınlık Kehribar: Açık modda okunaklılığı yüksek sıcak kehribar
  static const Color lightAmberAccent = Color(0xFFD97706);

  /// Aydınlık mod kenarlık rengi
  static const Color lightBorder = Color(0xFFCBD5E1);

  // --- DURUM & BİLGİLENDİRME RENKLERİ ---
  /// Başarı yeşili (Kiralama onayları için)
  static const Color success = Color(0xFF10B981);

  /// Hata kırmızısı (Form validasyon hataları için)
  static const Color error = Color(0xFFEF4444);

  /// Bilgilendirme mavisi
  static const Color info = Color(0xFF3B82F6);
}
// [ALT AÇIKLAMA]: AppColors sınıfı sayesinde uygulamanın tüm renk paleti tek bir merkezden yönetilir.
// Bu sayede gelecekte tema güncellemesi veya marka rengi değişimi tek bir dosyadan kolayca gerçekleştirilebilir.
