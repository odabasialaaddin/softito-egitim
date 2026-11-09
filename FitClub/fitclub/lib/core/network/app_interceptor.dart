import 'package:dio/dio.dart';

class AppInterceptor extends QueuedInterceptorsWrapper {
  // 1. İstek Sunucuya Gitmeden Önce Araya Girdiğimiz Yer (Request)
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Burada ileride yerel veritabanından (Hive/SecureStorage) kullanıcının 
    // giriş Token'ını alıp isteğin Header'ına (Başına) ekleyeceğiz.
    // Örnek: options.headers['Authorization'] = 'Bearer $kullaniciToken';
    
    // Şimdilik API'ye giderken ekstra bir dil parametresi ekleyelim
    options.headers['Accept-Language'] = 'tr-TR';
    
    return super.onRequest(options, handler); // İsteği yola çıkar
  }

  // 2. Sunucudan Başarılı Cevap Geldiğinde Araya Girdiğimiz Yer (Response)
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Burada gelen veriyi loglayabilir veya standart bir parse işleminden geçirebiliriz.
    return super.onResponse(response, handler);
  }

  // 3. Sunucudan Hata Döndüğünde Araya Girdiğimiz Yer (Error)
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Eğer gelen hata 401 (Yetkisiz İşlem / Token Süresi Dolmuş) ise:
    if (err.response?.statusCode == 401) {
      // TODO: Burada Refresh Token mekanizması çalışacak.
      // Yeni token alınacak ve hata veren istek (err.requestOptions) 
      // yeni token ile tekrar edilecek (Retry).
      
      // Şimdilik mekanizmanın taslağını kurduk, ileride Auth (Giriş) modülünü yazarken içini dolduracağız.
    }
    
    return super.onError(err, handler); // Hatayı UI katmanına veya fpdart'a ilet
  }
}