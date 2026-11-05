import 'package:flutter/material.dart';
import '../models/arac_kaydi_modeli.dart';
import '../services/i_servis_kayit_servisi.dart';
import '../services/mock_servis_kayit_servisi.dart';
import '../widgets/arac_ozet_karti.dart';
import '../widgets/onay_dialogu.dart';
import 'arac_detay_ekrani.dart';
import 'yeni_arac_ekle_ekrani.dart';

class AracListesiEkrani extends StatefulWidget {
  const AracListesiEkrani({super.key});

  @override
  State<AracListesiEkrani> createState() => _AracListesiEkraniState();
}

class _AracListesiEkraniState extends State<AracListesiEkrani> {
  final IServisKayitServisi _servis = MockServisKayitServisi();
  List<AracKaydiModeli> _araclar = [];

  @override
  void initState() {
    super.initState();
    _listeyiYenile();
  }

  void _listeyiYenile() {
    setState(() {
      _araclar = _servis.tumunuGetir();
    });
  }

  Future<void> _yeniAracEkraninaGit() async {
    final eklendiMi = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => YeniAracEkleEkrani(servis: _servis),
      ),
    );

    if (eklendiMi == true) {
      _listeyiYenile();
    }
  }

  Future<void> _detayEkraninaGit(AracKaydiModeli secilenArac) async {
    final guncellendiMi = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => AracDetayEkrani(
          arac: secilenArac,
          servis: _servis,
        ),
      ),
    );

    if (guncellendiMi == true) {
      _listeyiYenile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtoServis Kayıtları'),
        centerTitle: true,
      ),
      body: _araclar.isEmpty
          ? const Center(
              child: Text('Henüz kayıtlı araç bulunmuyor.'),
            )
          : ListView.builder(
              itemCount: _araclar.length,
              itemBuilder: (context, index) {
                final arac = _araclar[index];

                return Dismissible(
                  key: ValueKey(arac.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    final onay = await showDialog<bool>(
                      context: context,
                      builder: (context) => OnayDialogu(
                        baslik: 'Kaydı Sil',
                        icerik:
                            '${arac.plaka} plakalı aracı silmek istediğinize emin misiniz?',
                      ),
                    );
                    return onay == true;
                  },
                  onDismissed: (direction) {
                    _servis.kayitSil(arac.id);
                    _listeyiYenile();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${arac.plaka} kaydı silindi.'),
                      ),
                    );
                  },
                  child: AracOzetKarti(
                    arac: arac,
                    onTap: () => _detayEkraninaGit(arac),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _yeniAracEkraninaGit,
        icon: const Icon(Icons.add),
        label: const Text('Araç Ekle'),
      ),
    );
  }
}