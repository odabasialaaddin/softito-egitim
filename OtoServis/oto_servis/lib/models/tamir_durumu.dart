import 'package:flutter/material.dart';//görsel tasarım kütüphanesini projeye dahil eder.

//kodun bir yerinde yanlışlıkla "sırada" yerine "sirada" yazıp hata yapabilirdik, enum sayesinde sistem sadece bu 3 seçeneği kabul eder ve type safety sağlanmış olur.
//enum: bir veri tipinin alabileceği sabit ve sınırlı seçenekleri listelemek için kullanılır.
enum TamirDurumu {//sabit seçenekler listesi.
  sirada,
  parcaBekliyor,
  tamamlandi;//";" yani seçeneklerim bitti özelliklerim başlıyor demek.

  String get baslik {
    switch (this) {//şu an üzerinde işlem yaptığımız enum değeri hangisiyse ona bak ve eşleşeni bul diyoruz.
      case TamirDurumu.sirada:
        return 'Sırada';//eşleşen duruma göre return dışarı fırlatır.
      case TamirDurumu.parcaBekliyor:
        return 'Parça Bekliyor';
      case TamirDurumu.tamamlandi:
        return 'Tamamlandı';
    }
  }

  Color get renk { //yukardakinden tek farkı string değil renk dönüyor.
    switch (this) {
      case TamirDurumu.sirada:
        return Colors.orange;
      case TamirDurumu.parcaBekliyor:
        return Colors.redAccent;
      case TamirDurumu.tamamlandi:
        return Colors.green;
    }
  }
}