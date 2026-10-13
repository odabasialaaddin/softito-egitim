/*Future<void> fetchDashboardData() async {
  try {
    final result = await Future.wait([
      fetchUserProfile(),
      fetchAccountBalance(),
      fetchNotification(),

    ], eagerError: true);

    print("tüm veriler geldi $result");

  }catch(e){
    print("isteklerden biri bşarısız oldu.");
  }
}
*/

//Future: tek bir veri çekeceğimiz zaman kullanıyoruz.ya hata ya da değer dönüp getirir.
//Stream: Bir boru hattı şeklinde çalışır. (pipe), zaman içinde 1 10 100 ya da sonsuz sayıda veri akışı sağlar.
//(borsa fiyatları, gps konum güncelleme, firebase canlı dinleme yaptığımızda)

import 'dart:async';

void main(){

//controller olusturma
  final controller= StreamController<int>();
  //dinleyici (listenir) bağlama
  final subscription = controller.stream.listen(
    (data)) => print("yeni veri: $data"),
    onError: (err) => print("hata oluştu: $err"),
    onDone: () => print("yayın tamamlandı"),
    );

    controller.sink.add(10);
    controller.sink.add(20);
    controller.sink.add(30);


    final broadcastStream=controller.stream.asBroadcastStream();
    broadcastStream.listen((d)=>print(UI Ekranı: $d"));
    broadcastStream.listen((d)=>print("Analitik Servisi Ekranı $d"));



    controller.close();

}