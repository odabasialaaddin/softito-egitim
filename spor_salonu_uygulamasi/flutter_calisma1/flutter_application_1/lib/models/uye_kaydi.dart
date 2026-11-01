import 'uyelik_tipi.dart';

class UyeKaydi {
  final String id;
  final String adSoyad;
  final int yas;
  final String telefon;
  final UyelikTipi uyelikTipi;
  final DateTime kayitTarihi;
  final bool aktifMi;

  const UyeKaydi ({
    required this.id,
    required this.adSoyad,
    required this.yas,
    required this.telefon,
    required this.uyelikTipi,
    required this.kayitTarihi,
    this.aktifMi = true,
  });

  factory UyeKaydi.fromJson(Map<String, dynamic> json) {
    return UyeKaydi(
      id: json['id'] as String,
      adSoyad: json['adSoyad'] as String,
      yas: json['yas'] as int,
      telefon: json['telefon'] as String,
      uyelikTipi: UyelikTipi.fromJson(json['uyelikTipi'] as String),
      kayitTarihi: DateTime.parse(json['kayitTarihi'] as String),
      aktifMi: json['aktifMi'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adSoyad': adSoyad,
      'yas' : yas,
      'telefon' : telefon,
      'uyelikTipi' : uyelikTipi.name,
      'kayitTarihi' : kayitTarihi.toIso8601String(),
      'aktifMi' : aktifMi,
    };
  }

  UyeKaydi copyWith({
    String? id,
    String? adSoyad,
    int? yas,
    String? telefon,
    UyelikTipi? uyelikTipi,
    DateTime? kayitTarihi,
    bool? aktifMi,
  }) {
    return UyeKaydi(
      id: id ?? this.id,
      adSoyad: adSoyad ?? this.adSoyad,
      yas: yas ?? this.yas,
      telefon: telefon ?? this.telefon,
      uyelikTipi: uyelikTipi ?? this.uyelikTipi,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      aktifMi: aktifMi ?? this.aktifMi,
    );
  }
}