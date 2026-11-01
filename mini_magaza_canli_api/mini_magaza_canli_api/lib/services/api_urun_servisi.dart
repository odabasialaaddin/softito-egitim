import 'dart:convert';//gelen ham byte ve string verilerini json formatına çevirmek ve türkçe karakter sorunlarını çözmek için kullanılan yerleşik dart kütüphanesi.
import 'package:http/http.dart' as http;//internete çıkıp veri çekmemizi sağlayan paket.
import '../models/urun.dart';
import 'i_urun_servisi.dart';

class ApiUrunServisi implements IUrunServisi {
//değişken başındaki "_" değişkenin private oldugu anlamına gelir.
//böylece dışardan bir ekrandan yanlışlıkla url'i değiştiremez.
//static const olma sebebi ise bu değerlerin bellekte sadece bir kez oluşturulduğunu v e asla değişmeyeceğini garanti eder.
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const Duration _zamanAsimi = Duration(seconds: 10);

  @override
  Future<List<Urun>> urunleriGetir() async {

    try {
      //http paketi güvenlik ve standartlar gereği düz metin"String" kabul etmez. gerçek bir web adresi nesnesi "Uri" ister. 
      //bu satır, metni güvenli bir url adresine dönüştürür.
      final uri = Uri.parse('$_baseUrl/products');
      //await internetten yanıt gelene kadar kodu o satırda bekletir.
      //sonundaki .timeout kullanıcının interneti çok yavaşsa veeya sunucu çökmüşse uygulamanın sonsuza kadar dönen bir yükleme ekranında asılı kalmasını engeller.
      //10 saniye sonunda işlemi kesip hataya düşürür.
      final yanit = await http.get(uri).timeout(_zamanAsimi);

      if(yanit.statusCode == 200) {//eğer her şey yolunda ve veri geldiyse,

        final cozulmusGovde = utf8.decode(yanit.bodyBytes);//apiden gelen verilerdeki türkçe veya özel karakterlerin ekranda bozuk anlamsız semboller olarak görünmesini kesin olarak engeller.
        final List<dynamic> jsonListesi = jsonDecode(cozulmusGovde) as List<dynamic>;//internetten gelen düz metni dartın anlayabileceği gerçek bir liste yapısına çevirir.

        return jsonListesi
        //gelen listedeki her bir ham json paketini tek tek gezer map ile
        //daha önce yazdığımız urun.fromjson fabrikasına sokarak gerçek birer urun nesnesine dönüştürür.
        //.toList ise bu dönüştürülmüş akışı tekrar somut bir List<urun> haline getirip teslim eder.
        .map((oge) => Urun.fromJson(oge as Map<String, dynamic>))
        .toList();
      } else {
        throw Exception('Sunucu hatası: HTTP ${yanit.statusCode}');
      }
    } catch (hata) {
      rethrow;
    }
  }

  @override
  //gelen bir liste değil, tek bir ürün haritasıdır.
  Future<Urun?> urunGetirById(int id) async {

    try {
      final uri = Uri.parse('$_baseUrl/products/$id');
      final yanit = await http.get(uri).timeout(_zamanAsimi);

      if (yanit.statusCode == 200) {

        final cozulmusGovde = utf8.decode(yanit.bodyBytes);
        final Map<String, dynamic> jsonHaritasi = jsonDecode(cozulmusGovde) as Map<String, dynamic>;
        return Urun.fromJson(jsonHaritasi);
      } else {
        return null;
      }
    } catch (hata) {
      return null;
    }
  }
}