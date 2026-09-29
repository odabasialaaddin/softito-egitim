// 1. madde : cihaz tiplerini enumla olusturuyoruz.
enum CihazTipi {
  sensor,
  gateway,
  edgeServer,
  router,
}

// 8. madde : altyapı: özel exception sınıfı:
class CihazErisilemezException implements Exception {
  final String mesaj;

  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

// 2. madde : IoTCihaz Sınıfını Olusturun:
class IoTCihaz {
  final String seriNo;
  final String cihazAdi;
  final CihazTipi tip;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final Set<String> acikPortlar;
  final bool sslSertifikasiGecerliMi;
  final bool cihazAcikMi;

  IoTCihaz({
    required this.seriNo,
    required this.cihazAdi,
    required this.tip,
    required this.cpuYukYuzdesi,
    required this.bellekMb,
    required this.acikPortlar,
    required this.sslSertifikasiGecerliMi,
    this.cihazAcikMi = true,
  });

  // 2. madde : güvenlik acigi kontrolü (getter)
  bool get guvenlikAcigiVarMi =>
      !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");

  // 4 ve 6. maddeler için yardımcı getter : cihaz genel olarak riskli mi ?
  bool get riskliMi => guvenlikAcigiVarMi || cpuYukYuzdesi > 85.0;

  // 7. madde: cihaz tipine göre izolasyon bölgesi :
  String izolasyonBolgesiGetir() {
    return switch (tip) {
      CihazTipi.sensor => "ZONE-S (Sensör Ağı)",
      CihazTipi.gateway => "ZONE-G (Geçit Ağı)",
      CihazTipi.edgeServer => "ZONE-E (Uç Sunucu Ağı)",
      CihazTipi.router => "ZONE-R (Çekirdek Yönlendirici Ağı)",
    };
  }

  // 8. madde tetikleyici : cihaza bağlanma/ping atma metodu:
  void cihazaBaglan() {
    if (!cihazAcikMi) {
      throw CihazErisilemezException(
        "Hata [$seriNo]: '$cihazAdi' cihazı kapalı oldugu icin baglantı sağlanamadı",
      );
    }

    print(
      "BAŞARILI [$seriNo]: '$cihazAdi' cihazına bağlantı sağlandı. (CPU: %$cpuYukYuzdesi)",
    );
  }
}

// 6. madde : seri numarasına göre cihaz bulma: dart 3 record
// bulunamazsa null döndürmesi için dönüş tipini Nullable Record yaptık.
(String cihazAdi, CihazTipi tip, bool alarmDurumu)? seriNoIleCihazBul(
  List<IoTCihaz> cihazlar,
  String arananSeriNo,
) {
  for (final cihaz in cihazlar) {
    if (cihaz.seriNo == arananSeriNo) {
      // cihaz bulunduysa dart 3 record formatında paketleyip döndür.
      return (cihaz.cihazAdi, cihaz.tip, cihaz.riskliMi);
    }
  }

  // cihaz listede yoksa null döndür
  return null;
}

void main() {
  // 3. madde: 6 farklı IoT cihazı oluşturma :
  final List<IoTCihaz> agdakiCihazlar = [
    IoTCihaz(
      seriNo: "SN-101",
      cihazAdi: "Sıcaklık Sensörü A1",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 15.5,
      bellekMb: 128,
      acikPortlar: {"80/HTTP", "443/HTTPS"},
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-102",
      cihazAdi: "Fabrika Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 65.0,
      bellekMb: 1024,
      acikPortlar: {"22/SSH", "23/TELNET", "443/HTTPS"}, // Risk: TELNET açık!
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-103",
      cihazAdi: "Kamera Analiz Edge Sunucu",
      tip: CihazTipi.edgeServer,
      cpuYukYuzdesi: 92.4, // Risk: CPU %85'ten büyük!
      bellekMb: 4096,
      acikPortlar: {"443/HTTPS", "8080/HTTP-ALT"},
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-104",
      cihazAdi: "Ana Bina Router",
      tip: CihazTipi.router,
      cpuYukYuzdesi: 45.0,
      bellekMb: 512,
      acikPortlar: {"80/HTTP"},
      sslSertifikasiGecerliMi: false, // Risk: SSL geçersiz!
    ),
    IoTCihaz(
      seriNo: "SN-105",
      cihazAdi: "Nem Sensörü B2",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 10.0,
      bellekMb: 64,
      acikPortlar: {"443/HTTPS"},
      sslSertifikasiGecerliMi: true,
      cihazAcikMi: false, // 8. Madde testi için bu cihazı KAPALI yaptık
    ),
    IoTCihaz(
      seriNo: "SN-106",
      cihazAdi: "Depo Yedek Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 88.0, // Risk: Hem CPU yüksek hem SSL geçersiz!
      bellekMb: 2048,
      acikPortlar: {"22/SSH"},
      sslSertifikasiGecerliMi: false,
    ),
  ];

  print("4. MADDE : RİSKLİ CİHAZLAR (.where)");
  // güvenlik açığı olan veya cpu yükü 85ten büyük olanları filtrele.
  final List<IoTCihaz> riskliCihazlar = agdakiCihazlar
      .where((cihaz) => cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85.0)
      .toList();

  for (final cihaz in riskliCihazlar) {
    print(
      "${cihaz.cihazAdi} (${cihaz.seriNo}) | CPU: %${cihaz.cpuYukYuzdesi} | Güvenlik Açığı : ${cihaz.guvenlikAcigiVarMi}",
    );
  }

  print("\n5. madde : toplam bellek kullanımı : (.fold)");
  final int toplamBellek = agdakiCihazlar.fold<int>(
    0,
    (oncekiToplam, cihaz) => oncekiToplam + cihaz.bellekMb,
  );

  print("Ağdaki tüm cihazların toplam bellek kullanımı : $toplamBellek MB");

  print("\n6. madde : seri numarasına göre cihaz bulma dart 3 record");
  for (final arananNo in ["SN-103", "SN-999"]) {
    final sonuc = seriNoIleCihazBul(agdakiCihazlar, arananNo);
    if (sonuc != null) {
      // paketi değişkenlere doğrudan açıyoruz :
      final (ad, tip, alarm) = sonuc;
      print("bulundu [$arananNo] -> Ad: $ad | Tip: ${tip.name} | Alarm: $alarm");
    } else {
      print(
        "Bulunamadı [$arananNo] -> Sistemde bu seri numarasına ait cihaz yok.",
      );
    }
  }

  print("\n7. madde: izolasyon bölgeleri:");
  for (final cihaz in agdakiCihazlar) {
    print(
      "${cihaz.cihazAdi} (${cihaz.tip.name}) -> ${cihaz.izolasyonBolgesiGetir()}",
    );
  }

  print("\n8. madde: cihaz erişim testi: exception & try-catch");
  // hem açık olan SN-101 i hem de kapalı olan SN-105 i test edelim.
  for (final cihaz in [agdakiCihazlar[0], agdakiCihazlar[4]]) {
    try {
      cihaz.cihazaBaglan();
    } on CihazErisilemezException catch (e) {
      print("yakalanan özel hata -> $e");
    } catch (e) {
      print("beklenmeyen genel hata -> $e");
    }
  }
}