import 'kategori.dart';
import 'degerlendirme.dart';

class Urun {
//değişkenlerin hepsi final olarak işaretlendi. urun nesnesi yaratıldıktan sonra asla değiştirilemez.
  final int id;
  final String baslik;
  final double fiyat;
  final String aciklama;
  final Kategori kategori;
  final String resimUrl;
  final Degerlendirme degerlendirme;
  final bool stoktaVarMi;
//const Urun kullanımı: nesnenin gerekirse derleme zamaında sabit yaratılabilmesini sağlar, hafıza kullanımını optimize eder.
  const Urun ({
    required this.id,//required = parametrenin verilmesini zorunlu kılar.
    required this.baslik,
    required this.fiyat,
    required this.aciklama,
    required this.kategori,
    required this.resimUrl,
    required this.degerlendirme,
    this.stoktaVarMi = true,
  });
//factory: json verisini dart nesnesine çeviren fabrika metot.
  factory Urun.fromJson(Map<String, dynamic> json) {//apiden gelen verinin anahtarlarının her zaman String örn: price değerlerinin ise belirsiz sayı,yazi,boolean oldugunu belirtir.


    return Urun(

      id: (json['id'] as num).toInt(),//api id değerini ondalıklı gönderse bile num bunu yakalar ve güvenle int tipine çevirir
      baslik: json['title'] as String? ?? 'İsimsiz Ürün',//jsondan title String olarak al, null gelirse sağındaki isimsiz ürün title'ını bas.
      fiyat: (json['price'] as num?)?.toDouble() ?? 0.0,//jsondan price değeri numla yakala. double olarak
      aciklama: json['description'] as String? ?? '',
      kategori: KategoriExtension.apiMetnindenUret(json['category'] as String? ?? ''),
      resimUrl: json['image'] as String? ?? '',
      degerlendirme: json['rating'] != null
      ? Degerlendirme.fromJson(json['rating'] as Map<String, dynamic>)
      :const Degerlendirme(puan: 0.0, oySayisi: 0),
      stoktaVarMi: ((json['rating']?['count'] as num?)?.toInt()?? 10) > 0,//jsondan rating gelir num ile tutulur inte çevrilir, eğer boşsa 10 atanır ve sıfır ile sınanır. 

    );
  }
//tüm değişkenleri final yaptığımız için objenin içindeki bir değeri örn: fiyat = 150 doğrudan değiştiremeyiz
//eski objeyi copyWith alır, sadece senin değiştirmek istediğin yeni değeri içeri yerleştirir. geri kalan tüm verileri eski objeden kopyalayarak yepyeni bir referans adresine sahip yeni bir ürün objesi döndürür.
//bloc vubit veya riverpod gibi state menagement yapıları arayüzü tetiklemek rebuild için verinin içeriğine değil ramddeki referans adresinin değişiğ değişmediğine bakar. bu yüzden copyWith kullamazsan değişiklikler ekrana yansımaz.
  Urun copyWith ({
    int? id,
    String? baslik,
    double? fiyat,
    String? aciklama,
    Kategori? kategori,
    String? resimUrl,
    Degerlendirme? degerlendirme,
    bool? stoktaVarMi,
  }) {
    return Urun(//metodu çağıran yere servis ediyoruz.
      id: id ?? this.id,//eğer dışardan yeni bir parametre gelirse onu koy, verilmediyse eski objemdeki this mevcut değerini kopyala.
      baslik: baslik ?? this.baslik,
      fiyat: fiyat ?? this.fiyat,
      aciklama: aciklama ?? this.aciklama,
      kategori: kategori?? this.kategori,
      resimUrl: resimUrl ?? this.resimUrl,
      degerlendirme: degerlendirme ?? this.degerlendirme,
      stoktaVarMi: stoktaVarMi ?? this.stoktaVarMi,
    );
  }
}