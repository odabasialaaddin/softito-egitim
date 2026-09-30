//üst sınıf
class TemelSavasci{
  final String ad;
  final double temelGuc;

  TemelSavasci({
    required this.ad,
    required this.temelGuc,
  });

  void saldir() {
    print("[$ad] Temel Fiziksel Yumruk Atti. Hasar : $temelGuc");
  }
}


class Buyucu extends TemelSavasci{
  int manaPuani;

  Buyucu({
    required this.manaPuani,
    required super.ad,
    required super.temelGuc,
  });

  @override 
  void saldir(){
    if(manaPuani>=10){
      manaPuani -=10;
      print("[$ad] alev topu fırlattı: hasar : ${temelGuc*2}
      Kalan Mana: $manaPuani",
      );

    }else{
      print("mana tükendi");
      super.saldir();
    }
  }
}

class Okcu extends TemelSavasci{
  int okSayisi;

  Okcu({
    required this.okSayisi,
    required super.ad,
    required super.temelGuc,
  });

  @override
  void saldir(){
    if(okSayisi>0){
      okSayisi--;
      print(
        "[$ad] hedefe zehirli ok firlatti: Hasar: ${temelGuc * 1.5} kalan ok sayısı $okSayisi,");

    }else {
      print("ok bitti");
      super.saldir();
    }
  }
}

void main(){
  print("savaş arenası");
  final asker = TemelSavasci(ad: "Ayberk", temelGuc: "20.0");
  //yumruk atar
  asker.saldir();
  print("--------------------------------");
  final merlin = Buyucu(manaPuani : 20, ad : "Sümeyye Arab", temelGuc: 40.0);
  merlin.saldir();
  print("--------------------------------");
  final legolas = okcu(okSayisi: 5, ad: "Zelal", temelGuc : 35.0);
  legolas.saldir();

}