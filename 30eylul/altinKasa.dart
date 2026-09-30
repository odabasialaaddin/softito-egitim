class Kasa {
    final String oyuncuAdi;
    int _altinMiktari = 0;

    Kasa({
        required this.oyuncuAdi,
    });

    int get altinMiktari {
        return _altinMiktari;
    }

    set altinMiktari(int eklenecekAltin) {
        if(eklenecekAltin <= 0) {
            print("uyarı : [$oyuncuAdi]: Sahte altın eklenemez. (Girilen değer: $eklenecekAltin)");

        }else {
            _altinMiktari += eklenecekAltin;
            print("$oyuncuAdi kasasına $eklenecekAltin altın eklendi.")
        }
    }
}

void main(){
    print( "oyuncu kasa güvenlik sistemi");

    final oyuncuKasasi = Kasa(oyuncuAdi : "Selehaddin Çiftçi");
    print("başlangıç altını : ${oyuncuKasasi.altinMiktari} Altın\n");

    oyuncuKasasi.altinMiktari = 150;
    print("günncel kasa: ${oyuncuKasasi.altinMiktari} Altın\n");
    
    oyuncuKasasi.altinMiktari = 250;
    print("güncel kasa: ${oyuncuKasasi.altinMiktari} Altın \n");

    oyuncuKasasi.altinMiktari = -500;
    print("Nihai Kasa: ${oyuncuKasasi.altinMiktari} Altın");
}
