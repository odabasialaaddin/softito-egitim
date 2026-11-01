enum UyelikTipi {
  aylik(baslik : 'Aylık', gunSayisi: 30),
  ucAylik(baslik : '3 Aylık', gunSayisi: 90),
  yillik(baslik : 'Yıllık', gunSayisi: 365);

  final String baslik;
  final int gunSayisi;

  const UyelikTipi({
    required this.baslik,
    required this.gunSayisi,
  });

  static UyelikTipi fromJson(String deger) {
    return UyelikTipi.values.firstWhere(
      (tip) => tip.name == deger,
      orElse: () => UyelikTipi.aylik,
    );
  }
}