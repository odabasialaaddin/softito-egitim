```dart
//1- enumları(derleme zamanı güvenligi)
// Sabit seçenek kümeleri oluşturarak metin bazlı yazım hatalarını derleme aşamasında önler.

enum HizmetKategorisi {
  ciltYenileme,
  medikalEstetik,
  lazerEpilasyon,
  Lipo,
}

enum SeansDurumu {
  bekliyor,
  odadaIslemde,
  tamamlandi,
  iptalEdildi,
}

enum OdemeYontemi {
  krediKarti,
  havaleEft,
  nakit,
  klinikPaketKredisi,
}

//danisan (müsteri) modeli:
// Müşterilerin kimlik, iletişim, VIP ve sağlık bilgilerini tutan veri şablonudur.
class Danisan {
  // 'final' anahtar kelimesi, bu bilgilerin nesne oluşturulduktan sonra değiştirilmesini engeller.
  final String id;
  final String adSoyad;
  final String telefon;
  final bool vipUyeMi;
  final List<String> alerjiler; // bos olabilir ama null olamaz.
  final String? ozelCiltNotu; // opsiyonel null olabilir ('?' işareti bu alanın boş bırakılabileceğini belirtir).

  // Sınıfın kurucu metodudur (constructor); zorunlu (required) ve varsayılan değerli parametreleri alır.
  const Danisan({
    required this.id,
    required this.adSoyad,
    required this.telefon,
    this.vipUyeMi = false,
    this.alerjiler = const [],
    this.ozelCiltNotu,
  });

  // Alerji listesi boş değilse otomatik olarak 'true' döndüren okuma özelliğidir (getter).
  bool get hassasCiltMi => alerjiler.isNotEmpty;

  //bilgi özet kartı:
  // Danışanın tüm bilgilerini tek bir özet metin (String) haline getirip döndüren getter yapısıdır.
  String get bilgiOzeti {
    // Ternary (? :) operatörü ile alerji listesi boşsa uyarı yazar, doluysa elemanları virgülle birleştirir.
    final String alerjiBilgisi = alerjiler.isEmpty
        ? "Kayitli Alerji Yok"
        : "Alerjiler: ${alerjiler.join(', ')}";

    // '??' (if-null) operatörü ile özel cilt notu null ise sağdaki varsayılan metni kullanır.
    final String notBilgisi = ozelCiltNotu ?? "Özel medikat not girilmemiş";
    // Danışan VIP ise "VİP", değilse "STANDART" rozetini seçer.
    final String vipRozeti = vipUyeMi ? "VİP" : "STANDART";
    return "$vipRozeti $adSoyad ($telefon) | $alerjiBilgisi | Not: $notBilgisi";
  }
}

// seans randevu modeli:
// Yapılacak işlemin fiyat, danışan, uzman ve süreç durumunu tutan randevu sınıfıdır.
class SeansKaydi {
  final String seansKodu;
  final Danisan danisan;
  final HizmetKategorisi kategori;
  final String islemAdi;
  final double birimFiyat;
  final int seansSayisi;
  final double indirimOrani;
  final String? sorumluUzman;
  // Randevu durumu ve ödeme tipi sonradan güncellenebileceği için 'final' tanımlanmamıştır.
  SeansDurumu durum;
  OdemeYontemi? odemeTipi;

  SeansKaydi({
    required this.seansKodu,
    required this.danisan,
    required this.kategori,
    required this.islemAdi,
    required this.birimFiyat,
    this.seansSayisi = 1,
    this.indirimOrani = 0.0,
    this.sorumluUzman,
    this.durum = SeansDurumu.bekliyor, // Yeni açılan her randevu varsayılan olarak 'bekliyor' durumunda başlar.
    this.odemeTipi,
  });

  // Birim fiyat ile seans sayısını çarparak indirimsiz toplam tutarı hesaplar.
  double get brutTutar => birimFiyat * seansSayisi;

  // Danışanın mevcut indirim oranına, eğer VIP üye ise +%10 daha ekleyerek toplam indirim tutarınıTL cinsinden hesaplar.
  double get indirimTutari {
    double toplamOran = indirimOrani;
    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }

    return brutTutar * (toplamOran / 100.0);
  }

  // Brüt tutardan indirim tutarını çıkararak müşterinin ödeyeceği net tutarı verir.
  double get netTutar => brutTutar - indirimTutari;
}

// Kliniğin tüm danışanlarını, randevularını ve finansal hesaplamalarını yöneten ana sınıftır.
class KlinikYoneticisi {
  final String subeAdi;
  // Başındaki '_' işareti bu listelerin private (özel) olduğunu ve sınıf dışından doğrudan değiştirilemeyeceğini belirtir.
  final List<SeansKaydi> _seanslar = [];
  final Map<String, Danisan> _danisanRehberi = {};

  KlinikYoneticisi({required this.subeAdi});

//Danısan kaydetme:
  // Danışanı benzersiz ID numarasıyla (anahtar-değer şeklinde) klinik rehberine (Map) kaydeder.
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] = danisan;
    print("rehbere eklendi: ${danisan.adSoyad} (${danisan.vipUyeMi ? "VİP" : "STANDART"})");
  }

  // Oluşturulan bir seans nesnesini kliniğin seanslar listesine ekler.
  void randevuOlustur(SeansKaydi seans) {
    _seanslar.add(seans);
    print(
      "randevu kaydedildi [${seans.seansKodu}]: ${seans.danisan.adSoyad}-> ${seans.islemAdi}",
    );
  }

  // Verilen seans kodunu listede arar; bulduğunda durumunu 'tamamlandi' yapıp ödeme yöntemini kaydeder ve döngüden çıkar.
  void seansiTamamla({
    required String seansKodu,
    required OdemeYontemi odeme,
  }) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.tamamlandi;
        seans.odemeTipi = odeme;
        print(
          "seans tamamlandi, [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi (${odeme.name})",
        );
        return; // Seans bulunup işlem yapıldığı için fonksiyonu sonlandırır.
      }
    }
    print("hata [$seansKodu] kodlu seans bulunamadı.");
  }

  // İlgili seans kodunu listede bulup durumunu 'iptalEdildi' olarak günceller ve iptal gerekçesini yazdırır.
  void seansiIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.iptalEdildi;
        print(
          "seans iptal edildi [${seans.seansKodu}]: ${iptalNedeni ?? "Gerekce Belirtilmedi"}",
        );
        return;
      }
    }
  }

  // Sadece durumu 'tamamlandi' olan seansları filtreler (where) ve net tutarlarını üst üste toplayarak (fold) kasadaki ciroyu bulur.
  double get toplamTahsilEdilenCiro => _seanslar
      .where((s) => s.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // Durumu 'bekliyor' veya 'odadaIslemde' olan seansları filtreleyip kliniğin beklediği potansiyel geliri toplar.
  double get beklenenPotansiyelCiro => _seanslar
      .where(
        (s) =>
            s.durum == SeansDurumu.bekliyor ||
            s.durum == SeansDurumu.odadaIslemde,
      )
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // Her hizmet kategorisinden kaç adet seans olduğunu sayarak kategori bazlı istatistik sözlüğü (Map) döndürür.
  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    final Map<HizmetKategorisi, int> dagilim = {};
    // Önce tüm kategorilerin başlangıç sayısını 0 olarak ayarlar.
    for (var kat in HizmetKategorisi.values) {
      dagilim[kat] = 0;
    }

    // Listedeki her seansın kategorisini bulup sayacını 1 artırır.
    for (var s in _seanslar) {
      dagilim[s.kategori] = (dagilim[s.kategori] ?? 0) + 1;
    }

    return dagilim;
  }

  // Seanslardaki uzman isimlerini alır (map), null olmayanları seçer (whereType) ve aynı ismi iki kez yazmamak için küme (Set) olarak döndürür.
  Set<String> gorevliUzmanKadrosu() {
    return _seanslar
        .map((s) => s.sorumluUzman)
        .whereType<String>()
        .toSet();
  }

  //uzmansız kalan seanslar: 
  // Sorumlu uzmanı atanmamış (null olan) seansları filtreleyerek bir liste halinde döndürür.
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((s) => s.sorumluUzman == null).toList();
  }

  // Gün sonu tablosunu, finansal özeti, aktif uzmanları ve uzmansız seans uyarılarını konsola yazdırır.
  void gunSonuRaporuYazdir() {
    print("günlük seans ve islem cizelgesi");
    print("-------------------------------");
    // padRight(n) metodu, metnin sağına boşluk ekleyerek tablo sütunlarının düzgün hizalanmasını sağlar.
    print(
      "${'Kod'.padRight(10)} | "
      "${'Danışan'.padRight(16)} | "
      "${'İşlem'.padRight(20)} | "
      "${'Uzman'.padRight(18)} | "
      "${'Tutar'.padRight(10)} | "
      "${'Durum'} | ",
    );
    print("----------------------------------------");

    for (var s in _seanslar) {
      // Uzman atanmamışsa tabloda "Nöbetçi Bekliyor" yazmasını sağlar.
      final String uzman = s.sorumluUzman ?? " Nöbetçi Bekliyor";
      // Modern Dart switch-expression yapısı ile enum değerini okunabilir Türkçe metne çevirir.
      final String durumRozet = switch (s.durum) {
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal",
      };

      // Her bir seansın detaylarını tablo satırı olarak formatlayıp ekrana basar.
      print(
        "${s.seansKodu.padRight(10)} | "
        "${s.danisan.adSoyad.padRight(10)} | "
        "${s.islemAdi.padRight(10)} | "
        "${uzman.padRight(10)} | "
        "${s.netTutar.toStringAsFixed(2).padRight(10)} | "
        "$durumRozet",
      );
    }

    // toStringAsFixed(2) metodu, küsuratlı para tutarlarını virgülden sonra 2 basamak (örn: 1500.00) olacak şekilde gösterir.
    print("---------------------------------------");
    print("Finansal Özet:");
    print(
      " * Gerçekleşen (kasadaki net ciro) : ${toplamTahsilEdilenCiro.toStringAsFixed(2)}",
    );
    print(
      " * Bekleyen Potansiyen Alacak : ${beklenenPotansiyelCiro.toStringAsFixed(2)}",
    );
    print(" * Toplam Seans : ${_seanslar.length} Randevu");
    print("---------------------------------------");
    print("Aktif Uzmanlar");
    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      print("Kayıtlı Uzman Bulunamadı");
    } else {
      print(" ${uzmanlar.join(', ')}");
    }
    // Uzmanı olmayan seansları kontrol eder ve varsa uyarı listesi olarak ekrana basar.
    final uzmansizlar = uzmansizSeanslariGetir();
    if (uzmansizlar.isNotEmpty) {
      print(
        "Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır",
      );
      for (var u in uzmansizlar) {
        print("->[${u.seansKodu}] ${u.danisan.adSoyad} (${u.islemAdi})");
      }
    }
    print("---------------------------------------");
  }
}

// Uygulamanın çalışmaya başladığı ana giriş fonksiyonudur.
void main() {
  print("Klinik yönetim sistemi başlatılıyor....");
  // Şube adını vererek klinik yöneticisi nesnesini başlatır.
  final yonetici = KlinikYoneticisi(subeAdi: "Softito Bağcılar Şubesi");

  //danışanları oluşturalım
  // Danisan sınıfından 4 farklı müşteri nesnesi (d1, d2, d3, d4) üretilir.
  final d1 = Danisan(
    id: "DAN-101",
    adSoyad: "Ahmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol,Aspirin"],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

  final d2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ayşe Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: false,
    alerjiler: [],
  );

  final d3 = Danisan(
    id: "DAN-103",
    adSoyad: "Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol,Aspirin"],
  );

  final d4 = Danisan(
    id: "DAN-104",
    adSoyad: "Ahmet Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: [],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

  // Oluşturulan danışanları kliniğin rehberine kaydeder.
  yonetici.danisanKaydet(d1);
  yonetici.danisanKaydet(d2);
  yonetici.danisanKaydet(d3);
  yonetici.danisanKaydet(d4);

  // d1 ve d2 danışanlarının özet bilgi kartlarını kontrol amaçlı ekrana yazdırır.
  print("Danışan güvenlik kontrolü");
  print(d1.bilgiOzeti);
  print(d2.bilgiOzeti);
  print("------------------------------");

  // randevular oluşturuluyor
  // Danışanlar için 4 farklı seans/randevu nesnesi tanımlanır (seans2'de uzman bilerek boş bırakılmıştır).
  final seans1 = SeansKaydi(
    seansKodu: "SNS-2026-1",
    danisan: d1,
    kategori: HizmetKategorisi.Lipo,
    islemAdi: "Lipo gerisini bilmiyorum",
    birimFiyat: 6500.0,
    seansSayisi: 2,
    indirimOrani: 5.0,
    sorumluUzman: "Sümeyye Arab",
  );

  final seans2 = SeansKaydi(
    seansKodu: "SNS-2026-2",
    danisan: d2,
    kategori: HizmetKategorisi.ciltYenileme,
    islemAdi: "Medikal Cilt Bakımı",
    birimFiyat: 2500.0,
    seansSayisi: 1,
    indirimOrani: 0.0,
  );

  final seans3 = SeansKaydi(
    seansKodu: "SNS-2026-3",
    danisan: d3,
    kategori: HizmetKategorisi.lazerEpilasyon,
    islemAdi: "Lazer Epilasyon",
    birimFiyat: 3000.0,
    seansSayisi: 4,
    indirimOrani: 0.0,
    sorumluUzman: "Tuba Aydın",
  );

  final seans4 = SeansKaydi(
    seansKodu: "SNS-2026-4",
    danisan: d4,
    kategori: HizmetKategorisi.medikalEstetik,
    islemAdi: "Burun Estetiği",
    birimFiyat: 1500.0,
    seansSayisi: 3,
    sorumluUzman: "Alaaddin Odabaşı",
  );

  // Tanımlanan seansları klinik yönetim sisteminin listesine ekler.
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);
  yonetici.randevuOlustur(seans4);
  print("Seanslar Gönderiliyor");

  //seans 1 başarıyla tamamlanıyor (kredi kartı ile ödeme);
  // 1. seansı tamamlandı olarak işaretler ve ödemesini kredi kartı olarak kaydeder.
  yonetici.seansiTamamla(seansKodu: "SNS-2026-1", odeme: OdemeYontemi.krediKarti);
  //seans 2 başarıyla tamamlanıyor (nakit ödeme);
  // 2. seansı tamamlandı olarak işaretler ve ödemesini nakit olarak kaydeder.
  yonetici.seansiTamamla(seansKodu: "SNS-2026-2", odeme: OdemeYontemi.nakit);
  //seans 4 iptal ediliyor
  // İlgili seansı mazeret belirterek iptal durumuna geçirir.
  yonetici.seansiIptalEt("SNS-2026-04", iptalNedeni: "Danışanın şehir dışından tanıdığı geldiği için gelemedi");

  // Tüm işlemlerin ardından genel tablo ve ciro özetini içeren gün sonu raporunu ekrana basar.
  yonetici.gunSonuRaporuYazdir();
}