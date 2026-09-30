abstract class Canavar {
  final String ad;

  Canavar ({
    required this.ad
  });

  void kukre();
}

class KurtCanavari extends Canavar {

  KurtCanavari({required super.ad});

  @override
  void kukre(){
    print("$ad : AUUUUUUUUUUUU sesi Altaylardan Tuna'ya kadar yankılandı.");
  }
}

class EjderhaCanavari extends Canavar {
  EjderhaCanavari({required super.ad});

  @override
  void kukre(){
    print("$ad miyav xd")
  }
}

void main(){

  final kurt = KurtCanavari(ad: "Kızıl Pençe");
  final ejderha = EjderhaCanavari(ad: "kuyruklu felaket");

  final List<Canavar> zindandakiCanavarlar = [kurt, ejderha];

  for(final canavar in zindandakiCanavarlar);
}