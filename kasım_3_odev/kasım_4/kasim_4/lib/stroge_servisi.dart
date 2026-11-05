import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class StrogeServisi {
  final FirebaseStroge _stroge = FirebaseStorage.instance;

  Upload yuklemeBaslat({
    required File dosya,
    required String hedefDizin,
    required String dosyaAdi,
  }) {
    final Reference ref = _stroge.ref().child('$hedefDizin/$dosyaAdi');
    final metadata=SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'yukleyen' : 'Faik fahri fuat furkan fahrettin tek kişilik dev kadro',
      },
    );
    return ref.putFile(dosya, metadata);
  }
  task.snapshot.listen((TaskSnapshot snapshot){

    final double yuzde = snapshot.bytesTransferred / snapshot.totalBytes;
    print('yukleniyor %${(yuzde *100).toStringAsFixed(1)}');
  }) 
}