import 'package:flutter/material.dart';
import '../models/uye_kaydi.dart';
import '../models/uyelik_tipi.dart';

class YeniUyeFormEkrani extends StatefulWidget {
  const YeniUyeFormEkrani({super.key});

  @override
  State<YeniUyeFormEkrani> createState() => _YeniUyeFormEkraniState();
}

class _YeniUyeFormEkraniState extends State<YeniUyeFormEkrani> {
  final _formKey = GlobalKey<FormState>();

  final _adSoyadController = TextEditingController();
  final _yasController = TextEditingController();
  final _telefonController = TextEditingController();

  UyelikTipi _secilenTip = UyelikTipi.aylik;

  @override
  void dispose() {
    _adSoyadController.dispose();
    _yasController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  void _formuKaydet() {
    if (_formKey.currentState!.validate()) {
      final yeniUye = UyeKaydi(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        adSoyad: _adSoyadController.text.trim(),
        yas: int.parse(_yasController.text.trim()),
        telefon: _telefonController.text.trim(),
        uyelikTipi: _secilenTip,
        kayitTarihi: DateTime.now(),
        aktifMi: true,
      );

      Navigator.pop(context, yeniUye);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Üye Kaydı'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              TextFormField(
                controller: _adSoyadController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().length < 3) {
                    return 'Lütfen en az 3 karakterli geçerli bir ad soyad girin.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yasController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Yaş',
                  prefixIcon: Icon(Icons.cake_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Yaş alanı boş bırakılamaz.';
                  }
                  final yas = int.tryParse(deger.trim());
                  if (yas == null) {
                    return 'Lütfen sadece sayısal bir değer girin.';
                  }
                  if (yas < 12 || yas > 90) {
                    return 'Üye yaşı 12 ile 90 arasında olmalıdır.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Telefon Numarası',
                  prefixIcon: Icon(Icons.phone_outlined),
                  hintText: '05XX XXX XX XX',
                  border: OutlineInputBorder(),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().length < 10) {
                    return 'Lütfen geçerli bir telefon numarası girin (En az 10 hane).';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<UyelikTipi>(
                value: _secilenTip,
                decoration: const InputDecoration(
                  labelText: 'Üyelik Paketi',
                  prefixIcon: Icon(Icons.card_membership_outlined),
                  border: OutlineInputBorder(),
                ),
                items: UyelikTipi.values.map((tip) {
                  return DropdownMenuItem(
                    value: tip,
                    child: Text('${tip.baslik} (${tip.gunSayisi} Gün)'),
                  );
                }).toList(),
                onChanged: (yeniDeger) {
                  if (yeniDeger != null) {
                    setState(() => _secilenTip = yeniDeger);
                  }
                },
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _formuKaydet,
                icon: const Icon(Icons.save_outlined),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Üyeyi Kaydet', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}