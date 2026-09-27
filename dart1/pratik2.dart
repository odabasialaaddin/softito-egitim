void main (){

//1- tip güvenli liste tanımlama ve ekleme = .add

List<String> istasyonlar = ["Kadiköy DC", "Besiktas AC"];
istasyonlar.add("Uskudar Ultra DC"); //js deki push yerine add.

//2- spread(...) ile bagimsiz kopyalama: 

List<String> yeniKopya = [...istasyonlar, "Maltepe Hızlı"];
print("yeni liste : ", $yeniKopya);
print("kadiköy listede var mi? ${yeniKopya.contains('Kadiköy DC')}"); //true döner.

// map, where, any, every kullanımı:

List<int> istasyonGucleri = [180, 22, 120, 22, 300];

List<int> hizliIstasyonlar = istasyonGucleri.where((guc) => guc>100).toList();
print("100kW üstü hizlilar: $hizliIstasyonlar"");

List<String> formatliGucler = istasyonGucleri.map((guc) => $guc kW).toList();
print("formatlı liste: $formatliGucler");

int ilkYavasGuc = istasyonGucleri.firstHere((guc)=> guc<100);
print("bulunan ilk yavas güc: $ilkYavasGuc");

bppş ultraHizliVarMi = istasyonGucleri.any((guc) => guc>=300);
print("300 kW ve üstü var mı ? $ultraHizliVarMi");

int toplamGuc = istasyonGucleri.reduce((kumbara, guc) => kumbara +guc);
print("toplam güc kapasitesi: $toplamGuc kW");


















}