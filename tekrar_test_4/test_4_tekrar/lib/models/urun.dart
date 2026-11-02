class UrunModel {//modelimizi oluşturuyoruz
  final int id;//parametrelere final vererek mühürlüyoruz.
  final String baslik;
  final double fiyat;
  final String resimUrl;
  final String kategori;

  const UrunModel({
    required this.id,//required vererek zorunlu tutuyoruz.
    required this.baslik,
    required this.resimUrl,
    required this.fiyat,
    required this.kategori,
  });
//factrory ile jsondan nesneye çevrim sağlıyoruz. map'le dönüyoruz.
//eğer veriler gelmeiyse sağ taraftaki değerleri atıyoruz.
  factory UrunModel.fromJson(Map<String, dynamic> json) {
    return UrunModel(
      id: json['id'] as int? ?? 0,
      baslik: json['title'] as String? ?? 'İsimsiz Ürün',
      fiyat: (json['price'] as num?)?.toDouble() ?? 0.0,
      resimUrl: json['image'] as String? ?? '',
      kategori: json['category'] as String? ?? 'Genel',
    );
  }
}