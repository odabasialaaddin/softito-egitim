import '../models/arac_kaydi_modeli.dart';
import '../models/tamir_durumu.dart';
import 'i_servis_kayit_servisi.dart';

class MockServisKayitServisi implements IServisKayitServisi {
  final List<AracKaydiModeli> _liste = [
    const AracKaydiModeli(
      id: '1',
      plaka: '34 ABC 123',
      musteriAdi: 'Atilla Atilla',
      telefon: '0532 111 22 33',
      arizaTanimi: 'Periyodik bakım ve yağ değişimi',
      maliyet: 4500.0,
      durum: TamirDurumu.sirada,
    ),
    const AracKaydiModeli(
      id: '2',
      plaka: '06 DEF 456',
      musteriAdi: 'Ayşe Ayşe',
      telefon: '0544 222 33 44',
      arizaTanimi: 'Ön fren balataları değişimi ve disk kontrolü',
      maliyet: 3200.0,
      durum: TamirDurumu.parcaBekliyor,
    ),
    const AracKaydiModeli(
      id: '3',
      plaka: '35 GHI 789',
      musteriAdi: 'Fatma Fatma',
      telefon: '0555 333 44 55',
      arizaTanimi: 'Debriyaj baskı balata seti değişimi',
      maliyet: 12500.0,
      durum: TamirDurumu.tamamlandi,
    ),
    const AracKaydiModeli(
      id: '4',
      plaka: '46 JKL 012',
      musteriAdi: 'Murat Murat',
      telefon: '0530 444 55 66',
      arizaTanimi: 'Klima gazı dolumu ve polen filtresi değişimi',
      maliyet: 1800.0,
      durum: TamirDurumu.sirada,
    ),
    const AracKaydiModeli(
      id: '5',
      plaka: '31 MNO 345',
      musteriAdi: 'Merve Merve',
      telefon: '0505 555 66 77',
      arizaTanimi: 'Akü değişimi ve şarj dinamosu ölçümü',
      maliyet: 5400.0,
      durum: TamirDurumu.parcaBekliyor,
    ),
  ];

  @override
  List<AracKaydiModeli> tumunuGetir() {
    return List.unmodifiable(_liste);
    //unmodifiable= değiştirilemez, manipüle edilemez.
    //verilen bu listenin sonradan dışardan değiştirilmesine asla izin verme!
  }

  @override
  void kayitEkle(AracKaydiModeli kayit) {
    _liste.insert(0, kayit);
    //insert = eklemek.
    //İSTEDİMİZ SIRAYA eleman ekler. burda 0 diyerek en başa kayıt nesnesini yerleştir ekle dedik.
  }

  @override
  void kayitSil(String id) {
    _liste.removeWhere((arac) => arac.id == id);
    //removeWhere = şu şarta uyanları sil" demek.
    //listenin içindeki her bir aracı sırayla eline alır ve geçici olarak ona arac adını takar.
    //elime aldığım bu aracın id si silinmesi için dışardan gönderilen id ile aynı mı kontrolü yapar
    //eğer true ise removeWhere o aracı anında listeden siler.
  }

//
  @override
  void durumGuncelle(String id, TamirDurumu yeniDurum) {
    final index = _liste.indexWhere((arac) => arac.id == id);
    if (index != -1) {//aracın listede bulunduğunu kontrol ediyoruz eğer -1 değilse diyerek.
      _liste[index] = _liste[index].copyWith(durum: yeniDurum);
    }
  }
}