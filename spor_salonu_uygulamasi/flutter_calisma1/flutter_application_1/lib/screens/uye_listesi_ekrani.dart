import 'package:flutter/material.dart';
import '../models/uye_kaydi.dart';
import '../models/uyelik_tipi.dart';
import '../services/i_uye_servisi.dart';
import '../services/mock_uye_servisi.dart';
import '../widgets/uye_karti.dart';
import 'uye_detay_ekrani.dart';
import 'yeni_uye_form_ekrani.dart';

class UyeListesiEkrani extends StatefulWidget {
  final IUyeServisi? uyeServisi;

  const UyeListesiEkrani({super.key, this.uyeServisi});

  @override
  State<UyeListesiEkrani> createState() => _UyeListesiEkraniState();
}

class _UyeListesiEkraniState extends State<UyeListesiEkrani> {
  late final IUyeServisi _servis;

  List<UyeKaydi> _tumUyeler = [];
  bool _yukleniyorMu = true;
  String? _hataMesaji;

  String _aramaMetni = '';
  UyelikTipi? _seciliTip;

  @override
  void initState() {
    super.initState();
    _servis = widget.uyeServisi ?? MockUyeServisi();
    _verileriYukle();
  }

  Future<void> _verileriYukle() async {
    setState(() {
      _yukleniyorMu = true;
      _hataMesaji = null;
    });

    try {
      final gelenUyeler = await _servis.uyeleriGetir();
      if (!mounted) return;
      setState(() {
        _tumUyeler = gelenUyeler;
        _yukleniyorMu = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hataMesaji = 'Üyeler yüklenirken bir sorun oluştu.';
        _yukleniyorMu = false;
      });
    }
  }

  Future<void> _yeniUyeEkleSayfasiniAc() async {
    final yeniUye = await Navigator.push<UyeKaydi>(
      context,
      MaterialPageRoute(
        builder: (context) => const YeniUyeFormEkrani(),
      ),
    );

    if (yeniUye != null) {
      await _servis.uyeEkle(yeniUye);
      await _verileriYukle();
    }
  }

  Future<void> _uyeDetaySayfasiniAc(UyeKaydi secilenUye) async {
    final guncelUye = await Navigator.push<UyeKaydi>(
      context,
      MaterialPageRoute(
        builder: (context) => UyeDetayEkrani(uye: secilenUye),
      ),
    );

    if (guncelUye != null) {
      await _servis.uyeGuncelle(guncelUye);
      await _verileriYukle();
    }
  }

  List<UyeKaydi> get _filtrelenmisUyeler {
    return _tumUyeler.where((uye) {
      final isimUyuyorMu = uye.adSoyad
          .toLowerCase()
          .contains(_aramaMetni.trim().toLowerCase());
      final tipUyuyorMu =
          _seciliTip == null || uye.uyelikTipi == _seciliTip;

      return isimUyuyorMu && tipUyuyorMu;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spor Salonu Üyeleri'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _yeniUyeEkleSayfasiniAc,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Yeni Üye'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (deger) => setState(() => _aramaMetni = deger),
              decoration: InputDecoration(
                hintText: 'Üye adına göre ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Tümü'),
                  selected: _seciliTip == null,
                  onSelected: (_) => setState(() => _seciliTip = null),
                ),
                ...UyelikTipi.values.map((tip) {
                  return ChoiceChip(
                    label: Text(tip.baslik),
                    selected: _seciliTip == tip,
                    onSelected: (secildiMi) {
                      setState(() => _seciliTip = secildiMi ? tip : null);
                    },
                  );
                }),
              ],
            ),
          ),
          const Divider(height: 16),
          Expanded(
            child: _govdeyiOlustur(),
          ),
        ],
      ),
    );
  }

  Widget _govdeyiOlustur() {
    if (_yukleniyorMu) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hataMesaji != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            Text(_hataMesaji!, style: const TextStyle(fontSize: 16)),
            ElevatedButton.icon(
              onPressed: _verileriYukle,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
            ),
          ],
        ),
      );
    }

    final liste = _filtrelenmisUyeler;

    if (liste.isEmpty) {
      return const Center(
        child: Text(
          'Aradığınız kriterlere uygun üye bulunamadı.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      itemCount: liste.length,
      itemBuilder: (context, index) {
        final uye = liste[index];
        return UyeKarti(
          uye: uye,
          onTap: () => _uyeDetaySayfasiniAc(uye),
        );
      },
    );
  }
}