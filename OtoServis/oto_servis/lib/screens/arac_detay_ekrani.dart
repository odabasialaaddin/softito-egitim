import 'package:flutter/material.dart';
import '../models/arac_kaydi_modeli.dart';
import '../models/tamir_durumu.dart';
import '../services/i_servis_kayit_servisi.dart';
import '../widgets/durum_secici_alani.dart';

class AracDetayEkrani extends StatefulWidget {//dinamik//güncellenecek bir ekran çizeceğiz.
  final AracKaydiModeli arac;//arackaydimodeli tipinde bir arac değişkeni,
  final IServisKayitServisi servis;//IservisKayitservisi tipinde bir servis değişkeni.

  const AracDetayEkrani({
    super.key,//üst sınıfa keyi verdik.
    required this.arac,//arac ve servisi zorunlu kıldık.
    required this.servis,
  });

  @override// AracDetayEkranı tipinde dönecek bir State oluşturup createState başlatıyoruz. sağ tarafta arrow function ile git aracdetayekranistate'i başlat diyoruz.
  State<AracDetayEkrani> createState() => _AracDetayEkraniState();
}

class _AracDetayEkraniState extends State<AracDetayEkrani> {
  late AracKaydiModeli _guncelArac;//late yani çağrıldığında çalışacak bir değişken.
  bool _degisiklikYapildi = false;//şimdilik false

  @override
  void initState() {//initState i eziyoruz.
    super.initState();//initState'in özelliklerini superle alıyoruz.
    _guncelArac = widget.arac;//guncelArac değişkenimizin içine widget içindeki arac bilgilerini aktarıyoruz.
  }

  void _durumGuncellemePenceresiAc() {//durum güncelleme penceresi açıyoruz.
    showModalBottomSheet(
      context: context,//soldaki showmodelbottomsheet'in istediği context, sağdaki bizim context'imiz
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DurumSeciciAlani(
                seciliDurum: _guncelArac.durum,
                onChanged: (TamirDurumu yeniDurum) {
                  widget.servis.durumGuncelle(_guncelArac.id, yeniDurum);
                  setState(() {
                    _guncelArac = _guncelArac.copyWith(durum: yeniDurum);
                    _degisiklikYapildi = true;
                  });
                  Navigator.pop(sheetContext);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.pop(context, _degisiklikYapildi);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_guncelArac.plaka),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mevcut Durum',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: _guncelArac.durum.renk.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _guncelArac.durum.baslik,
                              style: TextStyle(
                                color: _guncelArac.durum.renk,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _bilgiSatiriOlustur('Müşteri Adı', _guncelArac.musteriAdi),
                      const SizedBox(height: 12),
                      _bilgiSatiriOlustur('Telefon', _guncelArac.telefon),
                      const SizedBox(height: 12),
                      _bilgiSatiriOlustur('Arıza Tanımı', _guncelArac.arizaTanimi),
                      const SizedBox(height: 12),
                      _bilgiSatiriOlustur(
                        'Tahmini Maliyet',
                        '${_guncelArac.maliyet.toStringAsFixed(2)} ₺',
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _durumGuncellemePenceresiAc,
                icon: const Icon(Icons.edit),
                label: const Text('Durumu Güncelle'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bilgiSatiriOlustur(String etiket, String deger) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiket,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          deger,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}