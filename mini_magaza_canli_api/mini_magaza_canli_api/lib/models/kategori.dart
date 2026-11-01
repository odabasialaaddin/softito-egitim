//önceden belirli ve sınırlı seçenekleri string metin olarak tutmak yerine enum ile tanımlamak mimari bir güvenliktir.
//elektronik kelimesini projenin farklı yerlerinde elle yazarsan,, bir yerde harf hatası yaptığında örN:elektronik hatası alırsın. 
enum Kategori {
  hepsi,
  elektronik,
  taki,
  erkekGiyim,
  kadinGiyim,
}
//extension ile enum'a fonksiyon yetenekleri ekliyoruz. 
extension KategoriExtension on Kategori {
  String get gorunenAd {//get yani getter veri okuyucu fonksiyondur. kodun içindeki teknik isimlendirmeleri yani erkekGiyim gib, kullanıcının ekranda göüreceği düzgün metinlere "Erkek Giyim" gibi dönüştürür.
    switch (this) {
      case Kategori.hepsi:
        return 'Tümü';
      case Kategori.elektronik:
        return 'Elektronik';
      case Kategori.taki:
        return 'Takı & Mücevher';
      case Kategori.erkekGiyim:
        return 'Erkek Giyim';
      case Kategori.kadinGiyim:
        return 'Kadın Giyim';
    }
  }
// static kelimesi: bu fonksiyonu kullanmak için bellekte yeni bir kategori objesi yaratmamıza gerek kalmaz. direkt kategoriExtension... diyerek sınıf üzerinden erişmemizi sağlar.
  static Kategori apiMetnindenUret(String apiMetni) {
    switch (apiMetni.toLowerCase().trim()) {//apiden gelen json büyük harf ya da boşlukla gönderse bile trim boşlukları siler. toLowerCase tümünü küçük harf yapar. switch kontrolü kusursuz çalışır.
      case 'electronics':
        return Kategori.elektronik;
      case 'jewelery':
        return Kategori.taki;
      case "men's clothing":
        return Kategori.erkekGiyim;
      case "women's clothing":
        return Kategori.kadinGiyim;
      default://varsayılan değer: sunucuda ilerde shoes diye yeni bir kategori eklenirse ve mobil uygulama henüz güncellenmediyse uygulama çökmek yerine default bloguna düşerek geçici olarak elektronik kategorisine atar.
        return Kategori.elektronik;
    }
  }
}