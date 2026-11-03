import 'package:cloud_firestore/cloud_firestore.dart';

class OgrenciModel {//veritabanına göndereceğimiz nesne kalıbımız.
  final String id;//parametrelerimizi belirliyoruz.
  final String adSoyad;
  final String projeAdi;
  final int notu;
  final DateTime kayitTarihi;

  const OgrenciModel({//ogrencimodel'ın constructor'ını kuruyoruz
    required this.id,//required ile alınmasını zorunlu kılıyoruz.
    required this.adSoyad,//this ile sınıfın en üstünde tanımladıgımız değişkenlerle dışardan parametre olarak gelen değişkenleri birbirine bağlar.
    required this.projeAdi,
    required this.notu,
    required this.kayitTarihi,
  });

  // Firestore'dan gelen ham dokümanı Dart nesnesine çeviren (parse eden) factory metodu
  //DocumentSnapshot = verinin kendisini barındıran Firebase belge paketi bunun içinde gelir.
  //doc o pakettir.
  factory OgrenciModel.fromFireStore(DocumentSnapshot doc) {
    final veri = doc.data() as Map<String, dynamic>? ?? {};//biz doc.data dan gelen verilerin anahtarlarını string, diğerlerini ise her türden olabilen dynamic yapsında olduğunu biliyoruz diye zorlarız.
    //doc.data paketin içindeki asıl veri havuzunu dışarı çıkarır.
    // ?? {} ile de eğer soldaki veri gelmediyse sağdakini ata diyoruz.

    return OgrenciModel(//şimdi OgrenciModeli dönderiyoruz/fırlatıyoruz.
      id: doc.id,//docdaki id'i al ve bizim id'mize at.
      adSoyad: veri['adSoyad'] as String? ?? "İsimsiz Öğrenci",//veritabanından adsoyadı al string olarak kabul et eğer veri gelmediyse isimsiz öğrenci yaz.
      projeAdi: veri['projeAdi'] as String? ?? "Henüz Projesi Yok",
      notu: (veri['notu'] as num?)?.toInt() ?? 0,//double veya int gelirse num ile yakala sonra int e çevir. boşsa da 0 ı bas.
      kayitTarihi: (veri['kayitTarihi'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
//bu sefer bizim nesnemizi map formatına çeviriyoruz. firebase'in anlayacağı formata paketliyoruz.
  Map<String, dynamic> toMap() {//
    return {
      'adSoyad': adSoyad,
      'projeAdi': projeAdi,
      'notu': notu,
      'kayitTarihi': FieldValue.serverTimestamp(),
      //serverTimestamp=google sonucusunun kendi saatini veritabanına kaydettiriyoruz.
    };
  }
}