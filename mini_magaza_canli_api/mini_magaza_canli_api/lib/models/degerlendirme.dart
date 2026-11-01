//bir ürünün kullanıcı puanını ve değerlendirmesini tutuyor.
//
class Degerlendirme {
  final double puan;
  final int oySayisi;
//değerlendirme sınıfının değişmez constructor'ı
// puan ve oy sayısının zorunlu olduğunu belirten parametreler
  const Degerlendirme({
    required this.puan,
    required this.oySayisi,
  });
// json haritasını modele çevirir.
  factory Degerlendirme.fromJson(Map<String, dynamic> json) {
    return Degerlendirme(
      puan: (json['rate'] as num?)?.toDouble() ?? 0.0,
      oySayisi: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
//Dart map koleksiyonunu döndürür
    return {
// Apinin beklediği 'rate/count' anahtarı ve değeri
      'rate' : puan,
      'count' : oySayisi,
    };
  }
}
//eğer projemizde puan ver gibi bir butonumuz olsaydı copyWith kullanırdık. şu anki senaryoda sadece veri okuyup ekrana çizdiğimiz için kullanılmayacak bir kod yazıp dosya şişirmemek en mantıklısı.