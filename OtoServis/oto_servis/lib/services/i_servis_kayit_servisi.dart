import '../models/arac_kaydi_modeli.dart';
import '../models/tamir_durumu.dart';
//sözleşme sınıfımız. bu abstract class sayesinde diğer sınıflar implement ettiklerinde içindeki metotları override yani ezmek zorunda bırakacağız.
abstract class IServisKayitServisi {
  List<AracKaydiModeli> tumunuGetir();
  
  void kayitEkle(AracKaydiModeli kayit);
  
  void kayitSil(String id);
  
  void durumGuncelle(String id, TamirDurumu yeniDurum);
}