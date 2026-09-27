//1- class yani kalıbı çiziyoruz.

class SarjIstasyonu {
  final String kod;
  final String ad;
  final int kapasiteSoket;
  final List<String> aktifSoketler;
  final double birimTL;

  // 2- constructor: 

  SarjIstasyonu({
    required this.kod,
    required this.ad,
    required this.kapasiteSoket,
    required this.aktifSoketler,
    required this.birimTL,

  });

  String musaitlikRaporu() {
    int bostaAdet = kapasiteSoket-aktifSoketler.length;
    return "$ad istasyonunda $bostaAdet adet soket boştadır."

  }

  double geceTarifesiHesapla(int indirimYuzdesi) {
    double indirim = birimTL * (indirimYuzdesi/100);
    return birimTL-indirim;
  }

}

void main() {

  final kadikoyIstasyonu = SarjIstasyonu(
    kod: "TR-IST",
    ad: "kadıköy dc",
    kapasiteSoket: 4,
    aktifSoketler: ["soketa", "soketb"],
    birimTL: 12.0,
  );

  print(kadıkoyIstasyonu.musaitlikRaporu());
  print("gece birim fiyat: ${kadikoyIstasyonu.geceTarifesiHesapla(20)} TL ");
}