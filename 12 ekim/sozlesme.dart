//soyutlama Abstraction Kavramı

//1. adım (sozlesmeler) Contract 
import 'dart:async';

///*
abstract class AuthReposity{
    Future<String>login(String email, String password);
    Future<void>logout();
    bool get isAuth;
}
//canlı uygulama
/*
class FirebaseAuthRepository implements AuthReposity{
    @override
    Future<String> login(String email, String password) async{
        //gercek firebase cagirisi
        return "firebase_token_xyz_123";
    }

    @override
    Future<void> logout() async{
        //firebase logout

    }

    @override
    bool get isAuth => true;

    //test ve offline simülasyon:

    class MockAuthReposity implements AuthReposity{
        @override
        Future<String> login(String email, String password) async{
            await Future.delayed(Duration(seconds: 1));
            return "mock_token_abc_789";
        }
       @override
        Future<void> logout()  async{}

        @override bool get isAuth => false;


    }
}

mixin Logger{
    void log(String msg)=> print("log: $msg");

}

mixin Analytics{
    void log(String msg) => ("analiz $msg)";
}


class PaymentService with Logger, Analytics{
    void pay(){
        log("ödeme yapıldı");
    } 
}

abstract class BaseWidget{}
//sadece baseViegeet ve alt sınıflarda kullanılabilir


mixin LifeLogger on BaseWidget {
    void logInit() => ("Widget baslatıldı");

}

extansion StringValider on String(
    bool get isValidEmail{
        final emailRegex = RegExp;
        return emailRegex.hasMatcbh(this);
    }
)

String toCapitalize() {
    if(isEmpty return this);
    return this[0].toUpperCase() + substring(1);
}

void main() {
    String email = "Selahaddin@kodvance.com";
    if(email.isValidEmail){
        print("gecerli e posta");
    }else{

        print("geçersiz e-posta");
    }
}

abstract class Identifiable{
    String get id;
}

//T tipi mutlaka Identifiable arayüzünü uygulamak zorundadır.
class GenericCache <T extends Identifiable>{
    final Map<String, T> _stroge= {};

    void save (T item) {
        _stroge[item.id] = item;
        print("ID:${item.id} önbelleğe alındı");
    }


    T? getById(String id) => _stroge[id];
}


void main(){
    print("1. senkron başladı");
    scheduleMicrotask((){
        print("2.Task Olustu (Vip Kuyruk)");
    });

    Future((){
        print("3. standart event kuyrugu");
    });
    Future.microtask((){
        print("4.future.microtask çalıştı.");
    });

    print("5. senkron kod tamamlandı.");
}
*/
