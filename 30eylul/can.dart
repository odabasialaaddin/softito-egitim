class CanSistemi{

final String karakterAdi;
double _canPuani = 100.0; // _ varken : bu değişkeni gizli olarak kodlar.

CanSistemi({
    required this.karakterAdi
});

// getter ile can puanı güvenli dışarıya okutma:
double get canPuani{
    return _canPuani;
}

set canPuani(double yeniCan) {
    if(yeniCan <= 0.0){
        _canPuani=0.0;
        print("$karakterAdi canı tükendi ve yere yığıldı");
    } else if (yeniCan > 100.0) {
        _canPuani = 100.0;
        print("can tamamen dolu(max 100 hp)");
    }else {
        _canPuani = yeniCan;
    }
}

bool get hayattaMi {
    return _canPuani > 0.0;
}




}


void main(){
    print("can barı güvenlik sistemi");

    final savasciCani = CanSistemi(karakterAdi: "Meltem Demir");
    print("başlagıç canı         :HP ${savasciCani.canPuani}");
    print("35 hasar alındı.");
    savasciCani.canPuani = 65.0;
    print("kalan can          : HP ${savasciCani.canPuani}");
    print("200 can veren iksir içildi");
    savasciCani.canPuani = 200.0;
    print("sabitlenen can :     HP ${savasciCani.canPuani}");
    print("ölümcül darbe aldı");
    savasciCani.canPuani = -50.0;
    print("nihai can          : HP ${savasciCani.canPuani}");
    print("savaşçı hayatta mı ?        : ${savasciCani.hayattaMi ? 
    'Evet' : 'Hayır (Öldü)'}"
    );
}













