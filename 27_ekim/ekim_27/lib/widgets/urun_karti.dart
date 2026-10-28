import 'package:flutter/material.dart';
import '../models/urun.dart';
import 'stok_rozeti.dart';

class UrunKarti extends StatelessWidget {

  final Urun urun;
  final VoidCallback onFavoriTiklandi;
  final VoidCallback onDetayTiklandi;

    const UrunKarti ({
      super.key,
      required this.urun,
      required this.onFavoriTiklandi,
      required this.onDetayTiklandi,
    });

    @override 
    Widget build(BuildContext context){
      return Card(
        margin : const EdgeInsets.symmetric(horizontal: 16, vertical:8),
        elevation:2,
        shape:RoundedRectagleBorder(borderRadius:BorderRadius.circular(12)),
        child:InkWell(

          borderRadius: BorderRadius.circular(12),
          onTap:onDetayTiklandi,
          child:Padding(

            padding:const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                ClipRect(
                  borderRadius:BorderRadius.circular(10),
                  child:Image.network(
                    urun.resimUrl,
                    width:90,
                    height:90,
                    fit:
                  )
                )
              ]
            ),
            )

        )
      )
    }
}