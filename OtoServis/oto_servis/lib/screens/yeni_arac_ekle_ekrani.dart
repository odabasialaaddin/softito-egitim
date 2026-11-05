import 'package:flutter/material.dart';
import '../models/arac_kaydi_modeli.dart';
import '../models/tamir_durumu.dart';
import '../services/i_servis_kayit_servisi.dart';
import '../widgets/durum_secici_alani.dart';

class YeniAracEkleEkrani extends StatefulWidget {
  final IServisKayitServisi servis;

  const YeniAracEkleEkrani({
    super.key,
    required this.servis,
  });

  @override
  State<YeniAracEkleEkrani> createState() => _YeniAracEkleEkraniState();
}

class _YeniAracEkleEkraniState extends State<YeniAracEkleEkrani> {
  final _formKey = GlobalKey<FormState>();

  final _plakaController = TextEditingController();
  final _musteriController = TextEditingController();
  final _telefonController = TextEditingController();
  final _arizaController = TextEditingController();
  final _maliyetController = TextEditingController();

  TamirDurumu _seciliDurum = TamirDurumu.sirada;

  @override
  void dispose() {
    _plakaController.dispose();
    _musteriController.dispose();
    _telefonController.dispose();
    _arizaController.dispose();
    _maliyetController.dispose();
    super.dispose();
  }

  void _kaydet() {
    if (_formKey.currentState!.validate()) {
      final yeniArac = AracKaydiModeli(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        plaka: _plakaController.text.trim().toUpperCase(),
        musteriAdi: _musteriController.text.trim(),
        telefon: _telefonController.text.trim(),
        arizaTanimi: _arizaController.text.trim(),
        maliyet: double.parse(_maliyetController.text.trim()),
        durum: _seciliDurum,
      );

      widget.servis.kayitEkle(yeniArac);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Araç Kaydı'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _plakaController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Plaka',
                  hintText: 'Örn: 34 ABC 123',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Plaka alanı boş bırakılamaz';
                  }
                  if (deger.trim().length < 7) {
                    return 'Geçerli bir plaka giriniz (En az 7 karakter)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _musteriController,
                decoration: const InputDecoration(
                  labelText: 'Müşteri Adı Soyadı',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Müşteri adı boş bırakılamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefon Numarası',
                  hintText: 'Örn: 0532 111 22 33',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Telefon numarası zorunludur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _arizaController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Arıza ve İşlem Tanımı',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Arıza açıklaması boş geçilemez';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _maliyetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tahmini Maliyet (₺)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (deger) {
                  if (deger == null || deger.trim().isEmpty) {
                    return 'Maliyet alanı zorunludur';
                  }
                  final sayi = double.tryParse(deger.trim());
                  if (sayi == null || sayi < 0) {
                    return 'Lütfen geçerli bir tutar giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DurumSeciciAlani(
                seciliDurum: _seciliDurum,
                onChanged: (yeniDurum) {
                  setState(() {
                    _seciliDurum = yeniDurum;
                  });
                },
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _kaydet,
                icon: const Icon(Icons.save),
                label: const Text('Kaydı Tamamla'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}