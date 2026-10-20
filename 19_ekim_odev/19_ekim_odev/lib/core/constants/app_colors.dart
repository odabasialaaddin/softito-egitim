import 'package:flutter/material.dart';

/// CanVer uygulaması renk paleti ve tema renk sabitleri.
///
/// Material 3 uyumlu Çift Tema mimarisine temel oluşturur:
/// - Karanlık Gece Klinik Paleti (Dark Crimson & Obsidian)
/// - Modern Medikal Aydınlık Palet (Clean Clinical Light)
abstract final class AppColors {
  // Private constructor ile sınıfın başlatılmasını engelliyoruz.
  AppColors._();

  // ===========================================================================
  // 1. TEMEL MARKA VE KAN KIRMIZISI RENKLERİ (BRAND & BLOOD CRIMSON)
  // ===========================================================================

  /// Birincil kan kırmızısı (Primary Blood Crimson)
  static const Color bloodCrimson = Color(0xFFD90429);

  /// Canlı/parlak klinik kırmızı (Vibrant Medical Crimson)
  static const Color bloodVibrant = Color(0xFFEF233C);

  /// Derin pıhtı/cerrahi kırmızısı (Deep Surgical Crimson)
  static const Color bloodDeep = Color(0xFF8D0801);

  /// Açık pembe/kırmızı vurgu tonu (Plazma & açık doku tonu)
  static const Color bloodLight = Color(0xFFFF4D6D);

  /// Çok açık pastel kırmızı (Aydınlık tema kart zeminleri ve rozetler için)
  static const Color bloodContainerLight = Color(0xFFFFECEF);

  /// Koyu kırmızı konteyner (Karanlık tema rozet ve kart vurguları için)
  static const Color bloodContainerDark = Color(0xFF491014);

  // ===========================================================================
  // 2. KARANLIK GECE KLİNİK PALETİ (DARK CRIMSON & OBSIDIAN)
  // ===========================================================================

  /// En derin obsidian siyahı zemin
  static const Color darkBackground = Color(0xFF0B0E14);

  /// Obsidian yüzey (Kartlar, paneller ve bileşen zeminleri)
  static const Color darkSurface = Color(0xFF131822);

  /// Yükseltilmiş yüzey (Modal bottom sheet, dialog ve açılır menüler)
  static const Color darkSurfaceElevated = Color(0xFF1C2331);

  /// Karanlık tema için sınır ve çizgi rengi
  static const Color darkBorder = Color(0xFF263042);

  /// Karanlık tema birincil metin (Yüksek kontrastlı cerrahi beyaz)
  static const Color darkTextPrimary = Color(0xFFF8FAFC);

  /// Karanlık tema ikincil metin (Gümüş medikal gri)
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  /// Karanlık tema sessiz/devre dışı metin
  static const Color darkTextMuted = Color(0xFF64748B);

  // ===========================================================================
  // 3. MODERN MEDİKAL AYDINLIK PALET (LIGHT CLINICAL PALETTE)
  // ===========================================================================

  /// Aydınlık klinik zemin (Yumuşak medikal kırık beyaz)
  static const Color lightBackground = Color(0xFFF8FAFC);

  /// Aydınlık yüzey (Saf klinik beyazı kartlar ve zeminler)
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Aydınlık tema hafif gri yüzey varyantı
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);

  /// Aydınlık tema sınır ve çizgi rengi
  static const Color lightBorder = Color(0xFFE2E8F0);

  /// Aydınlık tema birincil metin (Obsidian kömür siyahı)
  static const Color lightTextPrimary = Color(0xFF0F172A);

  /// Aydınlık tema ikincil metin (Koyu arduvaz füme)
  static const Color lightTextSecondary = Color(0xFF475569);

  /// Aydınlık tema sessiz/devre dışı metin
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // ===========================================================================
  // 4. MEDİKAL İKİNCİL VE VURGU RENKLERİ (ACCENT & SECONDARY)
  // ===========================================================================

  /// Klinik turkuaz (Oksijen, yaşam ve medikal infüzyon)
  static const Color medicalTeal = Color(0xFF0284C7);

  /// Cerrahi nane yeşili (Şifa, toparlanma ve başarı)
  static const Color medicalMint = Color(0xFF10B981);

  /// Donör moru/lila (Sadık bağışçı rozetleri ve istatistik vurguları)
  static const Color medicalPurple = Color(0xFF8B5CF6);

  // ===========================================================================
  // 5. KAN STOK SEVİYESİ VE SEMANTİK DURUM RENKLERİ (STOCK STATUS)
  // ===========================================================================

  /// Kritik stok seviyesi (Stok < %25 - Acil kan çağrısı)
  static const Color statusCritical = Color(0xFFDC2626);

  /// Düşük/Uyarı stok seviyesi (Stok %25 - %50 - Dikkat/Bağış bekleniyor)
  static const Color statusWarning = Color(0xFFF59E0B);

  /// Yeterli/İdeal stok seviyesi (Stok > %50 - Güvenli medikal seviye)
  static const Color statusOptimal = Color(0xFF10B981);

  /// Bilgilendirme seviyesi (Nötr medikal bilgi)
  static const Color statusInfo = Color(0xFF2563EB);

  // ===========================================================================
  // 6. GÖRSEL EFEKTLER VE IŞIMA TONLARI (GLOW & SHADOW)
  // ===========================================================================

  /// Karanlık temada kan kırmızısı ışıma (Neon crimson glow)
  static const Color crimsonGlow = Color(0x33D90429);

  /// Aydınlık mod için yumuşak kart gölgesi
  static const Color lightShadow = Color(0x0A0F172A);
}
