import 'package:test_4_tekrar/services/urun_servisi.dart';
import 'package:test_4_tekrar/models/urun.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//api servisimize IUrunServis sözleşmemizi imzalatıyoruz.
class CanliApiUrunServisi implements IUrunServisi {
  static const String _baseUrl = "https://fakestoreapi.com/products";
  //baseurl mizi "_" kulnnarak private veriyoruz ve içine url mizi gömüyoruz.

//urunleri getir metodunu eziyoruz.
  @override
  Future<List<UrunModel>> urunleriGetir() async { //Urun modeli List şeklinde urunleriGetir diyoruz ve asenkron olarak başlatıyoruz.
    try {//işler yolundaysa
      final yanit = await http// sunucudan gelen cevabın tamamı "yanit" isimli değişkene kaydedilir.
          .get(Uri.parse(_baseUrl))//uri sayesinde baseurl parse ediliyor .get ile alınıyor.
          .timeout(//timeout veriyoruz
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Ağ zaman aşımına uğradı.');
            },
          );

      if (yanit.statusCode == 200) {//eğer yanittan gelen kod 200 yani ok sa;
        final List<dynamic> hamListe = jsonDecode(yanit.body) as List<dynamic>;
        //dinamik tipli listemiz olan ham listeye yanıt içeriğini dolduruyoruz. yine list dinamik olarak.
        return hamListe//aldığımız hamListeyi döndürüyoruz.
            .map((eleman) => UrunModel.fromJson(eleman as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Sunucu Hatası: ${yanit.statusCode}');
      }
    } catch (e) {
      print('Ağ hatası: $e');
      rethrow;
    }
  }
}