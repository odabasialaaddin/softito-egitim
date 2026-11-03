import 'package:flutter/material.dart';
import 'package:kasim_3_odev/models/ogrenci_model.dart';
import 'package:kasim_3_odev/services/firestore_servisi.dart';

class FirestoreYonetimEkrani extends StatefulWidget {
  const FirestoreYonetimEkrani({super.key});

  @override
  State<FirestoreYonetimEkrani> createState() => _FirestoreYonetimEkraniState();
}

class _FirestoreYonetimEkraniState extends State<FirestoreYonetimEkrani> {
  final FireStoreOgrenciServisi _servis = FireStoreOgrenciServisi();
  //_servis: Arayüzün veritabanıyla konuşmasını sağlayacak tek yetkili köprümüz.
  //TextEditingController = Tip = kullanıcının klavyeden girdiği metni anlık olarak dinleyen okuyan ve gerektiğinde kod üzerinden silmemizi sağlayan bir kontrolcü sınıftır.
  final TextEditingController _adSoyadKontrolcusu = TextEditingController();
  final TextEditingController _projeKontrolcusu = TextEditingController();
  final TextEditingController _notKontrolcusu = TextEditingController();

  @override
  void dispose() {//başka ekrana geçtiğimizde çalışır.
    _adSoyadKontrolcusu.dispose();
    _notKontrolcusu.dispose();
    _projeKontrolcusu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {//
//bu metot geriye bir Widget döndürecek. build ile ekranı çizicez.
//Buildcontext = uygulamanın genel ağacı widget tree içinde nerde bulunduğunun konum bilgisidir.
    return Scaffold(//inşaatı başlatır ve geriye bir scaffold nesnesi döndürür. scaffold bize hazır bir tepe appbar. ve gövde body alanları sunar.
      appBar: AppBar(//tepe çubuğu widget'ının kendisidir.
        title: const Text("Canlı Firestore Ekranı"),//çubuğun başlık özelliği.
        backgroundColor: Colors.amber.shade600,//çubuğun arka plan rengi
      ),
      body: Column(//scaffold iskeletinin tepe çubuğundan arta kalan tüm ana gövdesini ifade eder.Column = içine konulan tüm widgetleri yukardan asagı sütun halinde alt alta dizer.
        children: [//column widget'ının çocukları. içersinde sadece 1 tane değil, köşeli parantez sayesinde bir Liste alacağını belirtir.
          // ÜST KISIM: Veri Giriş Formu
          Padding(//padding: içindeki nesnelerin ekranın kenarlarına yapışmasını engeller. 
            padding: const EdgeInsets.all(16.0),//her yönden margin/padding
            child: Column(//padding widget'ı sadece tek bir eleman child sarmalayabilir. formdaki elemanlar yine alt alta duracağı için column açıyoruz.
              children: [
                TextField(//kullanıcının klavyeden metin gireceği yer.
                  controller: _adSoyadKontrolcusu,//klavyeden girilen harfleri yakalar ve yukarda hafızada tanımladığımız TextEditingController a fiziksel olarak bağlyan damardır.
                  decoration: const InputDecoration(//kutunun görsel tasarımını çizgisi,yazısı,ikonu düzenler.
                    labelText: "Öğrenci Adı Soyadı",//kutu boşken içinde duran, tıklayınca küçülüp yukarı kayan animasyonlu etiket yazısı.
                    prefixIcon: Icon(Icons.person),//kutunun sol başına bir insan ikonu yerleştirir.
                  ),
                ),
                const SizedBox(height: 8),//ekrana görünmez bir kutu koyar. amacı widgetler arasına 8 piksellik dikey boşluk bırakmaktır.
                
                Row(//içindeki çocukları alt alta değil soldan sağa yan yana dizer.
                  children: [
                    Expanded(//row içinde kullanıldığında yanındaki diğer nesneler yerleştikten sonra kalan tüm yatay boşluğu dinamik olarak doldurulmasını sağlar. böylece proje adı kutusu sündürülerek tüm ekranı kaplar.
                      child: TextField(
                        controller: _projeKontrolcusu,
                        decoration: const InputDecoration(
                          labelText: "Proje Adı",
                          prefixIcon: Icon(Icons.work),//kutunun 
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 110,//not kutusunun sınırsız uzamasını istemediğimiz için onu 110 piksellik sabit genişliğe hapsediyoruz.
                      child: TextField(
                        controller: _notKontrolcusu,
                        keyboardType: TextInputType.number,//not kutusuna tıklandığında klavyenin harflerle değil doğrudan sayısal tuş takımıyla açılmasını emreder.
                        decoration: const InputDecoration(
                          labelText: "Not (0-100)",
                          prefixIcon: Icon(Icons.grade),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(//arka plan rengi olan gölgeli ve içinde hem ikon hem metin barındıran hazır buton yapısıdır.
                  style: ElevatedButton.styleFrom(//butonun görsel özelliklerini değiştirir. 
                    backgroundColor: Colors.pink,//arka planı pembe olarak değiştirir
                    foregroundColor: Colors.white,//üzerindeki yazı rengini beyaz yapar.
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: _yeniOgrenciKaydet,//butona basıldığında hangi fonk un çalışacağını belirtir.() yazmayarak butona basıldığında çalış emrini veririz.
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text("Buluta Kaydet"),
                ),
              ],
            ),
          ),
          
          const Divider(thickness: 2),
          
          // ALT KISIM: Servis üzerinden canlı veri dinleme
          Expanded(
            child: StreamBuilder<List<OgrenciModel>>(
              stream: _servis.ogrencileriCanliDinle(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Bulut hatası: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Henüz bulutta kayıtlı öğrenci yoktur."),
                  );
                }

                final List<OgrenciModel> ogrenciler = snapshot.data!;

                return ListView.builder(
                  itemCount: ogrenciler.length,
                  itemBuilder: (context, index) {
                    final ogrenci = ogrenciler[index];

                    return Dismissible(
                      key: Key(ogrenci.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(Icons.delete_forever, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        _servis.ogrenciSil(ogrenci.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${ogrenci.adSoyad} buluttan silindi.')),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: ogrenci.notu >= 80
                              ? Colors.green
                              : (ogrenci.notu >= 50 ? Colors.orange : Colors.red),
                          child: Text(
                            '${ogrenci.notu}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          ogrenci.adSoyad,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Proje: ${ogrenci.projeAdi}'),
                        trailing: IconButton(
                          onPressed: () => _notGuncelleDialog(ogrenci),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _yeniOgrenciKaydet() {
    final adSoyad = _adSoyadKontrolcusu.text.trim();
    final proje = _projeKontrolcusu.text.trim();
    final not = int.tryParse(_notKontrolcusu.text.trim()) ?? 0;

    if (adSoyad.isEmpty || proje.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen ad soyad ve proje adını giriniz.')),
      );
      return;
    }

    _servis.ogrenciEkle(adSoyad: adSoyad, projeAdi: proje, notu: not);
    _adSoyadKontrolcusu.clear();
    _projeKontrolcusu.clear();
    _notKontrolcusu.clear();
  }

  void _notGuncelleDialog(OgrenciModel ogrenci) {
    final TextEditingController dialogNotKontrolcusu =
        TextEditingController(text: ogrenci.notu.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Hatalı "-" işareti ve kırık parantez düzeltildi:
          title: Text('${ogrenci.adSoyad} - Not Güncelle'),
          content: TextField(
            controller: dialogNotKontrolcusu,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Yeni Not (0-100)",
              prefixIcon: Icon(Icons.edit_note),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                final yeniNot = int.tryParse(dialogNotKontrolcusu.text.trim());
                if (yeniNot != null) {
                  _servis.ogrenciNotuGuncelle(ogrenci.id, yeniNot);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${ogrenci.adSoyad} notu $yeniNot olarak güncellendi.')),
                  );
                }
              },
              child: const Text("Güncelle"),
            ),
          ],
        );
      },
    );
  }
}