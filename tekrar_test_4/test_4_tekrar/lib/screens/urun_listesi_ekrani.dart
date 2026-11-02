import 'package:flutter/material.dart';
import 'package:test_4_tekrar/services/canli_api_servisi.dart';
import 'package:test_4_tekrar/models/urun.dart';
import '../services/urun_servisi.dart';
//stateful yani dinamik ekran.
class UrunListesiEkrani extends StatefulWidget {
  //super.key ile üst sınıfa key yolluyoruz.
  const UrunListesiEkrani({super.key});
// urunlistesi ekranı metodumuzu eziyoruz. içini dolduruyoruz.
  @override
  //urun listesi ekranımızın içinde urunlistesi ekranı state'ini başlatıyoruz.
  State<UrunListesiEkrani> createState() => _UrunListesiEkraniState();
}
class _UrunListesiEkraniState extends State<UrunListesiEkrani> {
  // Bağımlılığımızı soyut sözleşme (Interface) üzerinden tanımlıyoruz
  final IUrunServisi _servis = CanliApiUrunServisi();
  //serviin içini canliapiurunservisle dolduruyoruz.

  List<UrunModel> _urunler = [];//urunModel tipinde urunler adında yeni bir liste oluşturuyoruz.
  bool _yukleniyor = true;//yükleniyor default olarak true verdik.
  String? _hataMesaji;//hata mesajını tanımladık, null olabilir dedik.

  @override
  //stateful'un initState metodunu eziyoruz.
  void initState() {
    super.initState();//üst sınıftan superle alıyoruz.
    _verileriGetir();//api çağrımızı olması gerektiği gibi initState içinde başlatıyoruz.
  }

  Future<void> _verileriGetir() async {//verileriGetir metodunu asenkron olarak başlatıyoruz.
    setState(() {//içerdeki değişkenlerin değerini değiştirdim, ekranı bu yeni duruma göre hemen baştan çiz diyor.
      _yukleniyor = true;//bu değer true oldugu an aşağıdaki iskelet kodunda yazdığımız şart çalışır ve ekranda dönen yükleme çemberi circular...belirir.
      _hataMesaji = null;//eğer kullanıcı daha önce tekrar dene butonuna bastıysa ve ekranda eski bir hata mesajı duruyorsa, o mesajı silip ekranı temizler.
    });

    try {//işler yolundaysa,
      final gelenUrunler = await _servis.urunleriGetir();//ile internetten verilerin inmesini beklersin(await)
      if (!mounted) return;//ekran kapandıysa (mounted) flutter o ekranı ramden siler. silinmiş bir ekranda setState tetiklemeye çalışırsan uygulama çöker.

      setState(() {
        _urunler = gelenUrunler;
        _yukleniyor = false;
      });
    } catch (e) {//işler yolunda değilse.
      if (!mounted) return;

      setState(() {
        // Servisteki rethrow sayesinde fırlatılan hatayı burada yakalıyoruz
        _hataMesaji = e.toString();
        _yukleniyor = false;
      });
    }
  }

  @override//build metodunu eziyoruz.
  Widget build(BuildContext context) {
    return Scaffold(//iskeleti başlatıyoruz.
      appBar: AppBar(
        title: const Text('Ürün Listesi'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _verileriGetir,
          ),
        ],
      ),
      body: _govdeyiOlustur(),
    );
  }

  Widget _govdeyiOlustur() {
    // 1. Durum: Veri internetten çekiliyor
    if (_yukleniyor) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2. Durum: Hata oluştu (Zaman aşımı veya sunucu hatası)
    if (_hataMesaji != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                _hataMesaji!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _verileriGetir,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Durum: Liste boş geldi
    if (_urunler.isEmpty) {
      return const Center(
        child: Text('Gösterilecek ürün bulunamadı.'),
      );
    }

    // 4. Durum: Veriler başarıyla geldi, sade bir liste halinde çiziyoruz
    return ListView.builder(
      itemCount: _urunler.length,
      itemBuilder: (context, index) {
        final urun = _urunler[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Image.network(
              urun.resimUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
            title: Text(
              urun.baslik,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(urun.kategori),
            trailing: Text(
              '${urun.fiyat.toStringAsFixed(2)} ₺',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}