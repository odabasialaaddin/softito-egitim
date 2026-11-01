import '../models/uye_kaydi.dart';
import '../models/uyelik_tipi.dart';
import 'i_uye_servisi.dart';

class MockUyeServisi implements IUyeServisi {
  final List<UyeKaydi> _uyeler = [
    UyeKaydi(
      id: '1',
      adSoyad: 'Alaaddin Odabaşı',
      yas: 25,
      telefon: '05111111111',
      uyelikTipi: UyelikTipi.yillik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 45)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '2',
      adSoyad: 'Fahri Faruk Sonat',
      yas: 26,
      telefon: '05111111112',
      uyelikTipi: UyelikTipi.ucAylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 15)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '3',
      adSoyad: 'Shahd Ragab',
      yas: 22,
      telefon: '05111111113',
      uyelikTipi: UyelikTipi.aylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 40)),
      aktifMi: false,
    ),
    UyeKaydi(
      id: '4',
      adSoyad: 'Betül Zağlı',
      yas: 22,
      telefon: '05111111114',
      uyelikTipi: UyelikTipi.yillik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 120)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '5',
      adSoyad: 'Ahmet Ahmet',
      yas: 22,
      telefon: '05111111115',
      uyelikTipi: UyelikTipi.aylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 5)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '6',
      adSoyad: 'Mehmet Mehmet',
      yas: 22,
      telefon: '05111111116',
      uyelikTipi: UyelikTipi.ucAylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 95)),
      aktifMi: false,
    ),
    UyeKaydi(
      id: '7',
      adSoyad: 'Ayşe Ayşe',
      yas: 22,
      telefon: '05111111117',
      uyelikTipi: UyelikTipi.yillik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 200)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '8',
      adSoyad: 'Selin Selin',
      yas: 20,
      telefon: '05111111118',
      uyelikTipi: UyelikTipi.aylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 12)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '9',
      adSoyad: 'Büşra Büşra',
      yas: 21,
      telefon: '05111111119',
      uyelikTipi: UyelikTipi.ucAylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 30)),
      aktifMi: true,
    ),
    UyeKaydi(
      id: '10',
      adSoyad: 'Merve Merve',
      yas: 32,
      telefon: '05111111110',
      uyelikTipi: UyelikTipi.aylik,
      kayitTarihi: DateTime.now().subtract(const Duration(days: 60)),
      aktifMi: false,
    ),
  ];

  @override
  Future<List<UyeKaydi>> uyeleriGetir() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return List.unmodifiable(_uyeler);
  }

  @override
  Future<void> uyeEkle(UyeKaydi yeniUye) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _uyeler.insert(0, yeniUye);
  }

  @override
  Future<void> uyeGuncelle(UyeKaydi guncelUye) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _uyeler.indexWhere((uye) => uye.id == guncelUye.id);
    if (index != -1) {
      _uyeler[index] = guncelUye;
    }
  }
}