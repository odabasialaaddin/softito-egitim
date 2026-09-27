// fonk geriye bir şey döndürmeyecekse void, döndürecekse int double string
//eğer bilginin girilmesi şartsa ve boş olamazsa required.

//1- geriye değer döndüren klasik fonk

double geceTarifesiHesapla(double birimFiyat, int indirimYuzdesi){
  double indirimMiktari = birimFiyat *(indirimYuzdesi/100);
  return birimFiyat - indirimMiktari; //sonucu dısarı double olarak fırlatır

}

// 2- isimlendirilmiş parametreli fonk = required 

void araciEkranaBas({
  required String marka,//girilmesi zorunlu
  required String model,//girilmesi zorunlu
  required double bataryaKwh,//girilmesi zorunlu
  String renk = "Beyaz",//zorunlu değil gönderilmezse otomatik beyaz
}) {
  print("gelen arac $marka $model renk: $renk batarya: $batarya kWh");
}

void main (){
  //1- fonk u çağırma : 

  double geceFiyati = geceTarifesiHesapla(12.0, 20);
  print("gece indirimli birim fiyat : $geceFiyati TL");

  //2- isimlendirilmiş fonk u cağırma:
  //dikkat! değerleri gönderirken isim: değer şeklinde yazıyoruz
  //sırası önemli değil.

  araciEkranaBas(
    marka: "Togg",
    model: "t10x", 
    bataryakWh: 88,
    renk: 'Gece Mavisi'
  );


  //renk parametresini hiç göndermesek bile varsayılan olarak beyaz yazar.

  araciEkranaBas(
    marka:"tesla",
    model:"modely",
    bataryakWh: 75,
  );
}

