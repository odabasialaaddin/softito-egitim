import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasim_3_odev/models/ogrenci_model.dart';

class FireStoreOgrenciServisi {//ui tarafından istek atacağımız sınıf.
  final CollectionReference _ogrencilerKoleksiyonu =
  //CollectionReference = firebase için tip belirlemesi.
  //"_" vererek sadece ogrencilerKoleksiyonuna bu dosyadan ulasılabileceğini söylüyoruz.
      FirebaseFirestore.instance.collection('ogrenciler');
      //Firebasefirestore= import ettiğimiz cloud_firestorenin ana kapısı. veritabanına yapılacka tüm istekler bu sınıf üzerinden başlatılır.
      //instance = uygulama hızlı veri çekmek istediğinde sıfırdan vveritabanı bağlantısı kurmasın, halihazırda açık olan tek bağlantıyı çağırsın.
      //o aktif bağlantının içine girer ve ismi 'ogrenciler'olan koleksiyonu işaretler. 
      //işlem bitince bu hedef noktası _ogrencilerKoleksiyonu adlı değişkene final olarka atanmış olur.

//bu listede ogrencimodel nesnelerinden oluşan bir liste "akacak = stream."
//ogrencileriCanliDinle = metot.
  Stream<List<OgrenciModel>> ogrencileriCanliDinle() {
    return _ogrencilerKoleksiyonu
        .orderBy('notu', descending: true)//firebase'a verileri rastgele getirme, içlerindeki 'notu' alanına bakarak sırala deriz. descending: true = azalan diyerek yüksek not alanın en üste gelmesini sağlarız.
        .snapshots()//veritabanının o anki halinin fotoğrafını çeker ve her veri değiştiğinde yeni bir foto çekip bize yollar.
        .map((snapshot) {//transform fonksiyonu. gelen karmaşık firebase fotosunu alır, açıp bizim anlayacağımız şekle dönüştürmek için döngüye sokar.
      return snapshot.docs//o fotonun içindeki dökümanın(öğrencilerin) ham listesi.
          .map((doc) => OgrenciModel.fromFireStore(doc))//o ham dökümman listesindeki her bir doc yani döküman elemanlarını tektek alır ve önce yazdığımız fromFireStore fabrikasına fırlatır. fabrika bunları işleyip ogencimodel nesnesi olrak geri kusar.
          .toList();//bu fabrikadan çıkan bu nesneleri list tipinde temiz bir diziye array'e çevirir ve nehirden akıtır.
    });
  }

  // Yeni öğrenci ekleme
  //void = işlem bittiğinde griye veri döndürmeyecek. işi yapıp tamamlanacak.
  Future<void> ogrenciEkle({//future diyerek sana gelecekte bir sonuç vereceğim, sen diğer işlerini yapmaya devam et deriz.
    required String adSoyad,//bu değişkenlerin boş bırakılması yasak.
    required String projeAdi,
    required int notu,
  }) async {//metoda içerde zaman alacak bir işllem yapacağımızı haber ediyoruz.
    try {//kodun sigortası.
    //add ile koleksiyona veri ekliyoruz. add komutu ıd yi bizim yerimize karmaşık bir metin olarak oluşturuyor.
      await _ogrencilerKoleksiyonu.add({//await sadece async olan metotlarda çalışır. kodun alt satıra indirmesini burda durdurur ve firebaseden cevap gelene kadar burda bekle der.
        'adSoyad': adSoyad,
        'projeAdi': projeAdi,
        'notu': notu,
        'kayitTarihi': FieldValue.serverTimestamp(),
        //FieldValue= firestore'de veriyi istemcide değil sunucu tarafında hesaplatmak istediğimizde kullaıyoruz.
        //serverTimestamp doğrudan google firebase sunucusunun saatine kitlenir.
      });
      print('Öğrenci başarıyla kaydedildi.');
    } catch (e) {
      print("öğrenci ekleme başarısız. $e");
      rethrow;//hatayı yakalayıp fırlatıyoruz. 
    }
  }

  // Özel ID (TC No vb.) ile kaydetme veya birleştirme (merge)
  Future<void> ogrenciIdIleKaydet({
    required String tcNo,
    required String adSoyad,
    required String projeAdi,
  }) async {
    await _ogrencilerKoleksiyonu.doc(tcNo).set({//.add rastgele id oluşturuyordu. doc ise hayır, id yi firebase değil benim verdiğim tc numarasını id olarak kullan diyoruz.
      'adSoyad': adSoyad,
      'projeAdi': projeAdi,
      'guncellemeTarihi': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));//normalde set komutu o tc numarasına ait bir öğrenci zaten varsa eski verileri silip tamamen yenisini yazar.
    //ama merge:(kaynaştır) true dersek, sadece güncellenen kısımları
  }

  // Tüm öğrencileri tek seferlik (Future) liste olarak çekme
  Future<List<OgrenciModel>> tumOgrencileriGetir() async {
    try {
      //QuerySnapshot = firebase'in bize döneceği yanıtın tipidir. sorgunun sonucu olan bir sürü döküman listesi ve meta veri barındıran dev bir paket.
      final QuerySnapshot snapshot = await _ogrencilerKoleksiyonu
          .orderBy('notu', descending: true)
          .get();//tek seferlik. çeker veriyi getirir firebase ile bağlantıyı kapatır.
      return snapshot.docs
          .map((doc) => OgrenciModel.fromFireStore(doc))
          .toList();
    } catch (e) {
      print("veri çekme hatası: $e");
      return [];//eğer internet yoksa uyg çökmesin diye boş bir liste döndürür. öğrenci bulunamadı olarak algılanır program hayatına devam eder.
    }
  }

  // Öğrenci notunu güncelleme
  Future<void> ogrenciNotuGuncelle(String documanId, int yeniNot) async {
    await _ogrencilerKoleksiyonu.doc(documanId).update({//update: sadece belirtilen alanı örneğin saece notu değiştirir. öğrencinin adına veya projesine dokunmaz.
      'notu': yeniNot,
      'sonDuzenleme': FieldValue.serverTimestamp(),
    });
  }

  // Öğrenciyi silme
  Future<void> ogrenciSil(String documanId) async {
    await _ogrencilerKoleksiyonu.doc(documanId).delete();//siler
    print('$documanId referanslı veri tamamen silindi');
  }
}