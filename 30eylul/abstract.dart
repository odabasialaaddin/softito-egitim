abstract class LoncaUyesi {
  final String rumuz;

  LoncaUesi({required this.rumuz});

//Soyut metot abstract method
  void ozelYetenekKullan();

  void loncaSelamVer() {
    print("$rumuz Lonca Bayrağını Selamladı : 'Onur ve zafer için'");
  };
}

class Sovalye extends LoncaUyesi{
  Sovalye({required this.rumuz});

  @override
  void ozelYetenekKullan(){
    print("$rumuz Demir Kalkanını kaldırdı ve savunma duvarı ördü");
  }
}

class Sifaci extends LoncaUyesi {

  Sifaci({required super.rumuz});

  @override
  void ozelYetenekKullan(){
    print("$rumuz kutsal ışık büyüsüyle tüm takımın canını tazeledi");
  }
}

void savasAlanindaKomutVer(List<LoncaUyesi> takim) {
  print("Liderin Emriyle Takım Yetenekleri Devreye Girsin");

  for(var t in takim) {
    t.loncaSelamVer();
    t.ozelYetenekKullan();
  }
}

void main(){
  print("Lonca Takımı");
  final List<LoncaUyesi> loncaBirligi=[
    Sovalye(rumuz: "Kızıl Şovalye Adil"),
    Sifaci(rumuz: "Orman Perisi Shahd"),
    Sovalye(rumuz: "Gümüş muhafız eren"),

  ];

  savasAlanindaKomutVer(loncaBirligi);
}

