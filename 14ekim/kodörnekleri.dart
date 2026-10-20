Center( //widget ortalar.
    child: Column( // 2. widget: alt alta dizer.
        children: [
            Text('Merhaba!'),// 3. widget: yazı
            Icon(Icons.favorite),//4. widget: kalp ikonu
        ]
    )
)

//StatelessWidget Ornegi:

class Selam extends StatelessWidget {
    final String isim; //disardan gelen bilgi
    const Selam({super.key, required this.isim});

    @override
    Widget build(BuildContext context) {
        return text ('Merhaba $isim'); //hep aynı çıktı.
    }
} 

// StatefulWidget Ornegi:

class IsikAnahtari extends StatefulWidget {
    const IsikAnahtari({super.key});

    @override
    State<IsikAnahtari> createState () => _IsikAnahtariState();
}

class _IsikAnahtariState extends State<IsıkAnahtari> {
    bool acik = false; //degisebilen bilgi = STATE

    @override
    Widget build(BuildContext context) {
        return Switch(
            value: acik,
            onChanged: (yeni) {
                setState(() {
                    acik = yeni;
                });
            },
        );
    }
}

// Ekranda değişen bir şey varsa sayaç yazı kutusu internetten gelen veri => StatefulWidget
//Ekran hep ayniysa => StatelessWidget.

// !!!! yasam dongusu metotlari initState, dispose vb sadece StatefulWidget State sınıfında bulunur. StatelessWidget'da sadece build vardır

//BUTONA BASINCA SAYI ARTAN BİR UYGULAMA YAPALIM: 

import 'package: flutter/material.dart';

void main () => runApp(const MaterialApp(home: SayacSayfasi()));

class SayacSayfasi extends StatefulWidget{
    const SayacSayfasi({super.key});

    @override
    State<SayacSayfasi> createState() => _SayacSayfasiState();
}

class _SayacSayfasiState extends State<SayacSayfasi>{
    int sayac = 0; // state : değişen bilgi.

    void artir() {
        setState(() { //bir şey değişti, ekranı yenile!
            sayac++;
        });
    } 

    @override
    Widget build(BuildContext context ){ //build = ekranı çizen metot.

        return Scaffold(
            appBar: AppBar(title: const Text ('Sayaç')),
            body: Center(
                child: Text('$sayac', style: const TextStyle(fontSize: 48)),
            ),

            floatingActionButton: floatingActionButton(
                onPressed: artir,
                child: const Icon(Icons.add),
            ),
        );
    } 
} 

//butona basınca setState cagrilir. flutter : bilgi değişti build'i tekrar calistirip ekranı yenilemeliyim"der.
// setState olmadan sayac++ yazarsan değişken artar ama ekran güncellenmez. Çünkü Flultter'a haber vermemiş oluruz.


//YAŞAM DÖNGÜSÜ NEDİR ? 

//YAŞAM DÖNGÜSÜ METOTLARI:

/* Yumurta oluşur  => createState() => mounted = true
civciv doğar, ilk hazırlıklar => initState()
çevreyi tanır => (hava, mevsim) => didChangeDependencies
görünüşünü gösterir => build
ailesi ona yeni bir şey verir => didUpdateWidget
evden çıkmaya hazırlanır => deactivite
eşyalarını toplar, ışığı kapatır => dispose.

1- createState() - State nesnesi oluşturulur.
2- initState() - bir kere calisir. hazırlık.
3- didChangeDependencies()- çevre bilgileri hazır.
4- build - ekran çizilir
EKRAN YAŞARKEN TEKRAR TEKRAR
setState() / didUpdateWidget() -> yeniden build().
5- deactivate() - ağaçtan çıkarılıyor.
6- dispose() - temizlik. son adım.

INIT STATE VE DİSPOSE EŞ ÇALIŞIR. İNİTSTATE' TE BİR ŞEY AÇIYORSAN, DİSPOSE'TA ONU KAPATIRSIN.

*/

/*
createState: 
Ne zaman : widget ilk kez ağaca eklenirken, bir kere.
Ne yapar: State nesnesini üretir. Genelde sadece tek satır yazarsın, başka bir şey yapmana gerek yok.

@override
State<Ornek> createState() => _OrnekState();

2- initState:
Ne zaman- State oluştuktan hemen sonra, ömründe yalnızca bir kez.
Ne yapılır: Controller oluşturmak, timer başlatmak, stream dinlemek, ilk veriyi istemek.
Ne yapılmaz : Theme.of ve ya MediaQuery kullanma bunlar için 3 e bak.

@override
void initState(){
super.initState();
_ctrl = TextEditingController();
print("dogdum!");
}

3- didChangeDependencies
Ne zaman*- initState ten hemen sonra ve widget ın bağlı olduğu bir dış bilgi tema ekran boyutu dil gibi değişince.
Ne yapılır: context ile çevre bilgisi okumak.

@override
void didChangeDependencies() {
super.didChangeDependencies();
final tema = Theme.of(context);
final boyut = MediaQuery.of(context).size;
}

4- build: 
ne zaman- ilk çizimde ve her setState, didUpdateWidget sonrası. Saniyede çok kez bile çalışabilir.
ne yapılır: sadece ekranı tarif eden widget döndürmek.
ne yapılmaz : internet isteği, setState, ağır hesaplama.

@override
Widget build(BuildContext context){
return Text('sayı: $sayac');
}

5- didUpdateWidget
ne zaman: parent(üstteki widget) bu widget a yeni parametre gönderince
ne yapılır: eski ve yeni değeri karşılaştırıp gerekiyorsa işlem yapmak.

@override
void didUpdateWidfet(covarient Ornek oldWidfet) {
super.didUpdateWidget(oldWidget);
if(oldWidget.deger != widget.deger) {
print('deger değişti: ${oldWidget.deger -> ${widget.deger}'})
    }
}

6- deactivate
ne zaman: widget ağaçtan çıkarılırken. genelde hemen ardından dispose gelir. başlangıç seviyesinde coğu zaman kullanmana gerek yok.

@override
void deactivate() {
super.deactivate();
}

6- dispose: 
ne zaman: widget sonsuza dek yok edilirken. ömründe bir kere.
ne yapılır: initState'te açtığın her şeyi kapat.

@override
void dispose() {
_ctrl.dispose();
super.dispose();
}

activate: widget global key ile ağaçta başka bir yere taşınınca geri döner. çok nadir kullanılır.
ressemble: sadece hot reload yaparken debug modda çağırılır.


SUPER KURALI : initState() -> didChangeDependencies -> didUpdateWidget _> super ilk satır
dispose -> super son satır.

ÖRNEK SIRALAMA KODU : 
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Ana()));

// Ana sayfa: Demo'yu göster/gizle
class Ana extends StatefulWidget {
  const Ana({super.key});
  @override
  State<Ana> createState() => _AnaState();
}

class _AnaState extends State<Ana> {
  bool goster = true;
  int deger = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (goster) Demo(deger: deger),
          ElevatedButton(
            onPressed: () => setState(() => deger++),
            child: const Text('Değeri artır'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => goster = !goster),
            child: const Text('Göster / Gizle'),
          ),
        ],
      ),
    );
  }
}

// Asıl demo widget
class Demo extends StatefulWidget {
  final int deger;
  const Demo({super.key, required this.deger});

  @override
  State<Demo> createState() {
    print('1) createState');
    return _DemoState();
  }
}

class _DemoState extends State<Demo> {
  int tik = 0;

  @override
  void initState() {
    super.initState();
    print('2) initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('3) didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant Demo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('   didUpdateWidget: ${oldWidget.deger} → ${widget.deger}');
  }

  @override
  Widget build(BuildContext context) {
    print('4) build');
    return TextButton(
      onPressed: () => setState(() => tik++),
      child: Text('Değer: ${widget.deger} | Tık: $tik'),
    );
  }

  @override
  void deactivate() {
    print('5) deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('6) dispose');
    super.dispose();
  }
}


// DİSPOSE'TE TEMİZLİK YAPIYORUZ!

initState'de açtıklarını dispose'de kapatırsın.


//UYGULAMANIN KENDİ YAŞAM DÖNGÜSÜ:

resumed - uygulama ekranda ve kullanımda
inactive- odak kaybı. örneğin telefon çalıyor.
hidden- uygulama artık görünmüyor
paused- arka planda
detached- flutter motoru ekrandan ayrıldı

15İleri seviye: flutter_hooks : 

class Sayac extends HookWidget {
  const Sayac({super.key});

  @override
  Widget build(BuildContext context) {
    final c = useAnimationController(duration: const Duration(seconds: 1));
    final text = useTextEditingController();   // dispose'u otomatik

    useEffect(() {
      final t = Timer.periodic(const Duration(seconds: 1), (_) {});
      return t.cancel;                          // dispose karşılığı
    }, []);

    return TextField(controller: text);
  }
}

// quiz soruları:
1- initState ömründe 1 kez çalışır. State oluştuktan hemen sonra(createState)
2-Butona basınca sayı değişiyor ama ekran yenilenmiyorsa ? setState kullanılmamış olabilir. değişkeni setState içinde değiştir.
3- TextEditingController'ı nerde oluşturur nerde kapatırsın ? initState de oluşturur dispose'de kapatırım
4- Theme.of(context)'i nerde kullanırsın ? didChangeDependencies'te kullanırız.
5- super.dispose() satırını nereye yazarsın? - en sona. önce kendi kaynaklarımızı temizleriz.
6- parent yeni bir parametre gönderdi hangi metot çalışır ? : didUpdateWidget çalışır.
7- await'ten sonra setState'ten önce ne yazmalısın ? if(!mounted) return;
8- uygulama arka plana geçtiğinde hangi durum oluşur ? paused.
9- widget gizlenip tekrar gösterilince tık sayısı neden sıfırlanır ? çünkü eski state dispose ile yok oldu. yeni bir state initState ile sıfırdan oluştu.
10- yaşam döngüsü metotları StatelessWidget'ta var mı ? yalnızca build var başka bir şey yok.