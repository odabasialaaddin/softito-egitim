import 'package:flutter/material.dart';
import '../models/arac_kaydi_modeli.dart';

class AracOzetKarti extends StatelessWidget {
  final AracKaydiModeli arac;//arackaydımodeli nesnesi şeklinde arac bilgisini alıyoruz.
  final VoidCallback onTap;//onTap değişkenine yeteneği kazandırdık.
  //VoidCallback = flutter'da parametre almayan ve geriye değer döndürmeyen tıklama fonksiyonu demektir. void function()

  const AracOzetKarti({//constructor yazdık.
    super.key,//üst sınıfa keyi verdik
    required this.arac,//arac ve onTap değişkenlerini zorunlu kıldık.
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {//build başlattık
    return Card(//ekrana hafif yüksekliği ve yuvarlatılmış köşeleri olan bir kart kutusu döndürür.
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),//kartın dışından boşluk bırakır. sağdan soldan üstten alttan
      elevation: 2,//kartın altına hafif gölge vererek ekrandan biraz yüksekteymiş hissi yaratır.
      child: InkWell(//inkwell = tıklandığında damla efekt verir
        onTap: onTap,//sol taraftaki onTap inkwell widget'ının kendi tıklanma özelliği. sağ taraftaki bizim yukarda constructor ile dışardan aldığımız görev.
        borderRadius: BorderRadius.circular(12),//ekran yumuşatma
        child: Padding(//kartın iç duvarları ile içerdeki elemanlar birbirine yapışmasın diye iç boşluk bileşeni ekler.
          padding: const EdgeInsets.all(12.0),//kartın içinden dört bir yandan iç boşluk bırakır.
          child: Row(//kartın içindeki elemanları yanyana dizmek için row açtık.
            children: [//yanyana dizilecek elemanların listesini başlatır.
              CircleAvatar(//satırın en soluna tam yuvarlak bir profil alanı çizer.
                backgroundColor: arac.durum.renk.withOpacity(0.15),//
                foregroundColor: arac.durum.renk,
                child: const Icon(Icons.directions_car),
              ),
              const SizedBox(width: 12),
              Expanded(//right overflowed erorunu çözer. ikon ve fiyat bölümü hallolduktan sonra kalan boşluğu bana ver ama asla bu sınırın dışına taşmama izin verme der.
                child: Column(//orta bölmeede plaka ve müşteri bilgisini alt alt dizmek için dikey sütun açar
                  crossAxisAlignment: CrossAxisAlignment.start,//sütun içindeki yazıları sol kenara starta hizalar.
                  children: [
                    Text(//üst satıra aracın plakasını kalın bold ve 16 punto büyüklüğünde yazar.
                      arac.plaka,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${arac.musteriAdi} • ${arac.arizaTanimi}',//2 metni string interpolation kullanarak birleştirir. yanyana.
                      maxLines: 1,//bu birleştirilmiş metin en fazla 1 satır olb.
                      overflow: TextOverflow.ellipsis,//metin orta alana sığmazsa taşan kısmı keser ve sonuna "..." koyar.
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(//kartın en sağında üstte fiyatı altta ise durum rozatini alt alta göstemek içni yeni bir dikey sütun açar.
                crossAxisAlignment: CrossAxisAlignment.end,//bu sütun kartın en sağında durdugu içn içindeki fiyat yazısını ve durumunu sağ kenara yaslar.
                children: [
                  Text(
                    '${arac.maliyet.toStringAsFixed(0)} ₺',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: arac.durum.renk.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      arac.durum.baslik,
                      style: TextStyle(
                        color: arac.durum.renk,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*Card: 
Neden açarız?: ekranda diğer elemanlardan ayrılan, gölgeli ve
köşeleri yuvarlatılmış bağımsız bir kutu görünümü elde etmek için.
Ne bekler ?: margin, elevation, child(içine konulacak bir widget).

Inkwell:
Neden açarız? Card tek başına tıklanamaz. kartı tıklanabilir yapmak
ve dokunulduğunda su damlası efekti vermek için açarız.
Ne bekler? onTap tıklanına çalışacak fonksiyon. borderRadius ve child.(tıklanacak içerik)

Padding:(İç nefes alanı)
Neden açarız? kartın içindeki ikon ve yazıların kartın kenar çizgilerine
sıfıra sıfır yapışmasını engellemek için.
Ne bekler? padding child.

Row: 
Neden açarız ? kartın içindeki 3 ana parçayı(ikon, plakabilgi fiyat)
yanyana dizmek için.
içine ne bekler? children(yanyana dizilecek birden fazla widget listesi.)

CircleAvatar:
Neden açarız? Row'un en soluna durum rengine duyarlı yuvarlak bir
ikon zemini koymak için.
Ne bekler? backgroundcolor, foregroundcolor(içindeki ikonun rengi)
child.

Expended:
Neden açarız? Row içinde uzun metinler ekranın sağından dışarı taşıp
hata vermesin diye; soldaki ikondan ve sağdaki fiyattan geriye kalan 
tüm orta boşluğu sen kapla demek için.
Ne bekler? child.(widget)

Column:
Neden açarız? Hem orta bölmede hem de sağ bölmede bilgileri alt alta 
dizmek için.
Ne bekler ? crossAxisAlignment, children[].

Container:
Neden açarız? Sadece bir yazının/text in. etrafına renkli ana plan,
iç boşluk ve yuvarlak kççşe vererek onu "rozet" badge haline getirmek
için. 
Ne bekler? padding, decoration, child.

Altın Kurallar:
Tek bir elemanı sarmalayan yapılar: 
Card, InkWell, Padding, Expanded, CircleAvatar, Container: child beklerler.
Birden fazla elemanı dizen iskelet yapılar:
Row, Column içine children[] (liste) bekler. */

