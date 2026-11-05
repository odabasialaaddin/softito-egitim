import 'tamir_durumu.dart';

class AracKaydiModeli {
  final String id;//final yani bu değişkenlerin değeri bir kere atandktan sonra yeni nesne oluşturup rastgele değiştirilemeyeceğini garanti eder.
  final String plaka;
  final String musteriAdi;
  final String telefon;
  final String arizaTanimi;
  final double maliyet;
  final TamirDurumu durum;//tipimiz önceki yazdığımız tamirdurumu enum'u.

  const AracKaydiModeli({
    required this.id,
    required this.plaka,
    required this.musteriAdi,
    required this.telefon,
    required this.arizaTanimi,
    required this.maliyet,
    required this.durum,
  });

//copyWith sayesinde mevcut aracın kopyasını çıkarıp sadece istediğimiz alanları değiştirebilmemizi sağlar.
  AracKaydiModeli copyWith({
    String? id,
    String? plaka,
    String? musteriAdi,
    String? telefon,
    String? arizaTanimi,
    double? maliyet,
    TamirDurumu? durum,
  }) {//return ile geriye yeni kopyayı dönücez.
    return AracKaydiModeli(
      id: id ?? this.id,
      plaka: plaka ?? this.plaka,
      musteriAdi: musteriAdi ?? this.musteriAdi,
      telefon: telefon ?? this.telefon,
      arizaTanimi: arizaTanimi ?? this.arizaTanimi,
      maliyet: maliyet ?? this.maliyet,
      durum: durum ?? this.durum,
    );
  }
}