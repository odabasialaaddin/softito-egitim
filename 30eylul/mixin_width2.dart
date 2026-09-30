mixin YuzmeYetisi {
  void dalisYap() {
    print("su altına daldı");
  }
}

class Denizci with YuzmeYetisi {
  final String ad;
  Denizci({required this.ad});

  void kendiniTanit() {
    print("ben denizci $ad, göreve hazırım.");
  }
}

void main() {
  print("mixin(yetenek aktarımı) sistemi \n");

  final denizci = Denizci(ad: "Barbaros");

  denizci.kendiniTanit();

  denizci.dalisYap();
}