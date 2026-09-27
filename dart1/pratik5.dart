//ekrana şarj istasyonunn bilgisini yazan istasyonBilgisiYazir 
//adında isimlendirilmiş parametre alan bir fonk yazalım:

void istasyonBilgisiYazdir({
  required String Lokasyon,
  required int gucKw,
  bool aktifMi = true,
}) {
  print("lokasyon: $Lokasyon guc: $guc aktifMi: $aktifMi")
}

void main() {

  istasyonBilgisiYazdir(
    Lokasyon: "vadi",
    guc: 180,
    aktifMi : false
  )

  
