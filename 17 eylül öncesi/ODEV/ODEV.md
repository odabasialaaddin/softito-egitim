MOBIL UYGULAMASI ODEVI

GOREV1: SOZDE KOD

BASLA
  EGER kullaniciGirisYaptiMi ESITTIR YANLIS ISE:
    Kullaniciyi "Giris Ekrani"na yonlendir
    BITIR 
  DEGILSE:
    Ana ekrani yukle
  
  DONGU: Kullanici urun secmeye devam ettigi surece
    secilenKahve = Kullanicinin sectigi urun
    sepeteEkle(secilenKahve)
  
  sepetTutari = Sepetteki urunlerin toplam fiyati
  cuzdanBakiyesi = Kullanicinin mevcut bakiyesi
  
  EGER cuzdanBakiyesi KUCUKTUR sepetTutari ISE:
    Kullaniciya "Bakiye Yukle" uyarisi goster
  DEGILSE:
    cuzdanBakiyesi = cuzdanBakiyesi - sepetTutari
    sunucuyaSiparisPaketiGonder()
    Kullaniciya "Siparis Basariyla Alindi" mesaji goster
BITIR

GOREV2: REST API UC NOKTASI VE JSON TASARIMI

1- SIPARIS OLUSTURMA ENDPOINTI
HTTP Metodu: POST
URL / Endpoint: /api/v1/siparisler
Header: Authorization: Bearer <token>, Content-Type: application/json
Ornek Request Body (JSON): 
  {"kahve_adi": "Latte", "boyut": "Buyuk", "adet": 1, "tutar": 85.50}
Basarili Sonuc HTTP Durum Kodu: 201 Created
Kullanici Giris Yapmamissa: 401 Unauthorized

2- CUZDAN BAKIYE SORGULAMA ENDPOINTI
HTTP Metodu: GET
URL / Endpoint: /api/v1/kullanici/bakiye
Ornek Response (JSON): 
  {"bakiye": 185.50, "para_birimi": "TRY"}
Sunucuda Beklenmeyen Hata Cikarsa: 500 Internal Server Error

MULAKAT SORUSU CEVABI:

GET istegi Idempotenttir (Esgucudur), POST istegi ise Idempotent degildir. Cunku GET istegi sadece bakiye bilgisini okur, arka arkaya defalarca atilsa bile sunucudaki durumu degistirmez. Ancak POST istegi her atildiginda veritabaninda yeni bir siparis olusturur ve bakiyeden tekrar tekrar para dusulmesine neden olur.

GOREV 3: Clean Code ve SOLID Prensip Teshisi

1. SRP (Tek Sorumluluk Prensibi) Ihlali
Bu sinif tek bir is yapmak yerine; indirim hesaplama, kredi karti tahsilati, veritabani kaydi ve SMS gonderimi gibi birbirinden tamamen bagimsiz 4 farkli sorumlulugu ustlenerek SRPyi ihlal etmistir. Cozum olarak bu devasa yapiyi; SiparisYoneticisi, OdemeServisi, VeritabaniServisi ve BildirimServisi gibi her birinin sadece tek bir gorevi olan kucuk siniflara bolmeliyiz.

2. OCP (Acik/Kapali Prensibi) Ihlali
Mevcut indirimHesapla fonksiyonu gelisime acik, degisime kapali (Open/Closed) kuralina aykiridir. Sisteme yeni bir musteri tipi (ornegin DOKTOR) eklendiginde, var olan ve calisan kodu (if-else bloklarini) acip degistirmek zorunda kalmamiz bu prensibin dogrudan ihlal edildigini gosterir.