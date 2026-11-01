import 'package:flutter/material.dart';

//bu sınıfın tek bir görevi var: dışardan gelen bool değerine göre ekrana yeşil veya kırmızı bir stok etiketi çizmek.
//içersinde kullanıcı etkileşimiyle değişecek dinamik bir durum olmadığı için Stateless.
class StokRozeti extends StatelessWidget {

  final bool stoktaVarMi;//bu widget'ı çağıran üst ekran, ürünün stok bilgisini bu widget'a göndermek zorundadır.
  
  const StokRozeti({
    super.key,
    required this.stoktaVarMi,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(//içindeki metni sarmalayan, ona arka plan rengi, çerççeve ve iç boşluk vermmemizi sağlayan temel kutu widget'dır.
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),//içindeki metni sarmalayan ona arka plan rengi çerçeve ve iç boşluk vermemizi sağlayan temel kutu widget'ıdır.
      decoration: BoxDecoration(//kutuyu görsel olarak süslediğimiz bölüm.
        color: stoktaVarMi//color özelliğini decoration kullanıyorsan boxdecoration içinde yazacaksın yoksa flutter çöker.
        ? Colors.green.shade50
        : Colors.red.shade50,

      borderRadius: BorderRadius.circular(12),
      border: Border.all(//rozetin etrafına 1 piksel kalınlıdıgnda bir dış çizgi çeker.
        color: stoktaVarMi//burda 3lü koşul var: stok varsa açık yeşil, yoksa açık kırmızı arka plan atanıyor.
          ? Colors.green.shade300
          : Colors.red.shade300,
        width: 1,
      ),
    ),

    child: Text(
      stoktaVarMi ? 'Stokta Var' : 'Tükendi',
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: stoktaVarMi
          ? Colors.green.shade800
          : Colors.red.shade800,
       ),
     ),
    );
  }
}