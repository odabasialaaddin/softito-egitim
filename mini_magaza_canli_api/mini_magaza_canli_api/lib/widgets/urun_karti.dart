import 'package:flutter/material.dart';
import '../models/urun.dart';
import '../models/kategori.dart';
import 'stok_rozeti.dart';

class UrunKarti extends StatelessWidget {
  final Urun urun;//kartın ekrana çizeceği tüm veriyi taşıyan model nesnesidir.
  final VoidCallback? onTap;//geriye değer döndürmeyen br fonk tipi. butona tıklayınca hangi ekrana gideceğine buton karar vermez.

  const UrunKarti({
    super.key,
    required this.urun,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(//hafif gölgesi ve yuvarlatılmış köşeleriyle ürün bilgilerini sarmalayan material design kutusudr.
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,//inkwell in ürettiği tıklama dalgası normalde dikdörtgen yayılır ve card ın yuvarlatılmış köşelerinden dışarı taşar.bunlara prüzsüzlük kazandırır.
      child: InkWell(//karta tıklanma özelliği kazandırır ve basıldığında altında yayılan o modern su dalgası animasyonunu üretir.
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(//liste ekranındaki ürün resminin, karta tıklandığında detay sayfasındaki büyük resme doğru uçarak/büyüyerek geçiş yapmasını sağlayan widgttir.
                tag: 'urun_resim_${urun.id}',
                child: ClipRRect(//resmin köşelerini yuvarlatır. internetten deasa boyutta bir foto gelse bile tasarım bozulmaz.
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      urun.resimUrl,
                      fit: BoxFit.contain,//ürün fotolarının kenarları kesilmeden en oy oranını koruyarak 80 80 kutunun içine tam sığmasını sağlar.
                      loadingBuilder: (context, child, loadingProgress) {//resim internetten inerken geçen sürede kutunnu boş kalmaması için çalışır.
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(//uzun ürün başlığı geldiğinde row sağa doğru sonsuza kadar uzanmaya çalışır. flutter ın meşhur sarı siyah şeritli right... erorunu alırsın. yazılara sadece resimden kalan boş alana yayılabilirsin, orayı aşamazsın der.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(//row = yatay satır. yatay satır ile 2 ye bölünmüş. solda 80 piksellik resim, sağda ise ürün bilgileri(column)
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          urun.kategori.gorunenAd,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        StokRozeti(stoktaVarMi: urun.stoktaVarMi),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      urun.baslik,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          urun.degerlendirme.puan.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${urun.degerlendirme.oySayisi})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${urun.fiyat.toStringAsFixed(2)} ₺',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}