import 'package:test_4_tekrar/models/urun.dart';

//sözleşmemizi yapıyoruz. bu uygulamada bu sözleşmeyi imzalayan herkes
//aşağıdaki metodu ezmek zorunda bırakılır.
abstract class IUrunServisi {
  Future<List<UrunModel>> urunleriGetir();
}

