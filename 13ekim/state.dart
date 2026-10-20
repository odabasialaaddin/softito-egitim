1- createState()

2- mounted == true

3- initState()

4- didChangeDependencies() (widget değişimlerinde tetiklenir.(thema.of(context) bu adımda güvenli olarak çalıştırılır.))

5- build(buildContext context) (UI burada döndürür. (Asla içinde asenkron işlem yapılmaz))

6- didUpdateWidget(oldWidget) (üst ebeveyn yeni bir parametre yolladığında çalışır.)

7 - deactivite() (ağaçtan geçici olarak kopma)

8- dispose() (kalıcı olarak kapatma(controller.dispose Stream.cancel) burda yapılır)

9- mounted == false