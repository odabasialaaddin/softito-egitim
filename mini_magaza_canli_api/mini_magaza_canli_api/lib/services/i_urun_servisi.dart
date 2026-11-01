import '../models/urun.dart';
//dart dilinde özel interfae kelimesi yok. 
//bu yüzden arayüzler abstract class olarak tanımlanır.
//baştaki I interface'i temsil eder.
//bu sınıf, projedeki diğer geliştiricilere eğer benim ürün servisimi yazacaksan,
//bu iki metodu kesinlikle içermek ve kurallarıma uymak zorundasın der.
//bu yaklaşım, kodun API ye sıkı sıkıya bağımlı olmaktan kuratrır.
//kullanıcı arayüzü uı veya bloc verinin nerden geldiğini umursamaz, sadece IUrunServisini tanır.
abstract class IUrunServisi {
//Future, internetten veri çekme işleminin zaman alacağını belirtir.
//uygulamanın o sırada donup kalmaması için işlem arka planda asenkron olarak yapılır
//Future "elimde şu an veri yok ama işlem bitince sana bu veriyi vereceğime söz veriyorum" anlamına gelir.
//alttaki metot, internetten birden fazla ürün çekeceğimiz için bir liste "List" döner.
  Future<List<Urun>> urunleriGetir();
//Tek bir ürün detayı çekmek içindir. sonundaki "?" işareti kritiktir. çünkü gönderdiğin id sunucuda silinmiş veya bulunmuyor olabilir.
//? ile bu ürün gelemiyor olabilir, null dönme ihtimaline hazırlıklı ol diyerek uyg çökmesini engelleriz.
  Future<Urun?> urunGetirById(int id);
}