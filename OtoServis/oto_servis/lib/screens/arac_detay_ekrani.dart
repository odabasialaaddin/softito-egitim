import 'package:flutter/material.dart';
import '../models/arac_kaydi_modeli.dart';
import '../models/tamir_durumu.dart';
import '../services/i_servis_kayit_servisi.dart';
import '../widgets/durum_secici_alani.dart';

class AracDetayEkrani extends StatefulWidget {
  final AracKaydiModeli arac;
  final IServisKayitServisi servis;

  const AracDetayEkrani({
    super.key,
    required this.arac,
    required this.servis,
  });

  @override
  State<AracDetayEkrani> createState() => _AracDetayEkraniState();
}

class _AracDetayEkraniState extends State<AracDetayEkrani> {
  late AracKaydiModeli _guncelArac;
  bool _degisiklikYapildi = false;

  @override
  void initState() {
    super.initState();
    _guncelArac = widget.arac;
  }

  void _durumGuncellemePenceresiAc() {
    showModalBottomSheet(
      context: context,
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