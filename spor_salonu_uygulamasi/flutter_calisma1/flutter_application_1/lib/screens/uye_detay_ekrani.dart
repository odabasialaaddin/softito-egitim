import 'package:flutter/material.dart';
import '../models/uye_kaydi.dart';
import '../models/uyelik_tipi.dart';
import '../widgets/uyelik_rozeti.dart';

class UyeDetayEkrani extends StatefulWidget {
  final UyeKaydi uye;

  const UyeDetayEkrani({super.key, required this.uye});

  @override
  State<UyeDetayEkrani> createState() => _UyeDetayEkraniState();
}

class _UyeDetayEkraniState extends State<UyeDetayEkrani> {
  late UyeKaydi _guncelUye;

  @override
  void initState() {
    super.initState();
    _guncelUye = widget.uye;
  }

  String _tarihFormatla(DateTime tarih) {
    final gun = tarih.day.toString().padLeft(2, '0');
    final ay = tarih.month.toString().padLeft(2, '0');
    return '$gun.$ay.${tarih.year}';
  }

  void _sureUzatmaPenceresiniAc() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              const Text(
                'Üyelik Süresini Uzat / Paket Yenile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              ...UyelikTipi.values.map((tip) {
                return ListTile(
                  leading: const Icon(Icons.bolt),
                  title: Text('${tip.baslik} Paket'),
                  subtitle: Text('+${tip.gunSayisi} Gün Eklenecek'),
                  trailing: FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        _guncelUye = _guncelUye.copyWith(
                          uyelikTipi: tip,
                          kayitTarihi: DateTime.now(),
                          aktifMi: true,
                        );
                      });
                      Navigator.pop(bottomSheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${_guncelUye.adSoyad} üyeliği ${tip.baslik} olarak yenilendi!',
                          ),
                        ),
                      );
                    },
                    child: const Text('Seç'),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bitisTarihi = _guncelUye.kayitTarihi.add(
      Duration(days: _guncelUye.uyelikTipi.gunSayisi),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _guncelUye);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Üye Detayı'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Hero(
                tag: 'uye-avatar-${_guncelUye.id}',
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  child: Text(
                    _guncelUye.adSoyad.isNotEmpty
                        ? _guncelUye.adSoyad[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                _guncelUye.adSoyad,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              UyelikRozeti(
                uyelikTipi: _guncelUye.uyelikTipi,
                aktifMi: _guncelUye.aktifMi,
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 12,
                    children: [
                      _bilgiSatiri(
                        Icons.cake_outlined,
                        'Yaş',
                        '${_guncelUye.yas}',
                      ),
                      const Divider(),
                      _bilgiSatiri(
                        Icons.phone_outlined,
                        'Telefon',
                        _guncelUye.telefon,
                      ),
                      const Divider(),
                      _bilgiSatiri(
                        Icons.calendar_today_outlined,
                        'Başlangıç Tarihi',
                        _tarihFormatla(_guncelUye.kayitTarihi),
                      ),
                      const Divider(),
                      _bilgiSatiri(
                        Icons.event_available_outlined,
                        'Bitiş Tarihi',
                        _tarihFormatla(bitisTarihi),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _sureUzatmaPenceresiniAc,
                  icon: const Icon(Icons.update),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Üyelik Süresini Uzat',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bilgiSatiri(IconData ikon, String baslik, String deger) {
    return Row(
      children: [
        Icon(ikon, size: 22),
        const SizedBox(width: 12),
        Text(baslik, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Text(
          deger,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}