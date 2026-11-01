import '../models/uye_kaydi.dart';

abstract class IUyeServisi {

  Future<List<UyeKaydi>> uyeleriGetir();

  Future<void> uyeEkle(UyeKaydi yeniUye);

  Future<void> uyeGuncelle(UyeKaydi guncelUye);
}