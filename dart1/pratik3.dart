void main() {
  List<int> tarifeler = [12, 9, 15, 8, 20];

  // GÖREV 1: Yeni tarife ekleme (Senin yazdığın kod - %100 Doğru!)
  tarifeler.add(18);
  print("Güncel Tarifeler: $tarifeler"); // [12, 9, 15, 8, 20, 18]

  // GÖREV 2: 10 TL'den büyük olanları süzme
  // Düzeltme 1: <int> tipi belirtildi, yeniTarife ismi sağa yazıldı.
  // Düzeltme 2: En sona .toList() eklendi.
  List<int> yeniTarife = tarifeler.where((tarifeTl) => tarifeTl > 10).toList();
  print("10 TL Üstü Tarifeler: $yeniTarife"); // [12, 15, 20, 18]

  // GÖREV 3: 25'ten büyük en az bir tarife var mı?
  // Düzeltme 3: Hesaplama kod çalışırken yapıldığı için 'const' yerine 'bool' (veya 'final') yazıldı.
  bool cokPahaliVarMi = tarifeler.any((pahali) => pahali > 25);
  print("25 TL'den pahalı var mı?: $cokPahaliVarMi"); // false
}