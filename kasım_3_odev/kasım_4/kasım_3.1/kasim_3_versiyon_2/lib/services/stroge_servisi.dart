import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class StrogeServisi {
  final FirebaseStorage _stroge = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<File?> gorselSec({bool kameradan=false}) async {
    final XFile? xFile = await _picker.pickImage(
      source: kameradan ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if(xFile == null) return null;
    return File(xFile.path);
  }

  UploadTask yuklemeBaslat({
    required File dosya,
    required String dosyaAdi,
    String kolasor = 'yuklemeler',
  }) {
    final Referance ref = _stroge.ref().child('$klasor/$dosyaAdi');
    final metadata = SettableMetadata(
      contentType: 'image/png' ,
      customMetadata: {'ekleyen' : 'Berat Atmaca'},
    );
    return ref.putFile(dosya, metadata);
  }
  Future<String> urlGetir(Reference ref) async {
    return await ref.getDownloadURL();
  }

  Future<void> dosyaSil(String dosyaYolu) async {
    final Reference ref = _stroge.ref().child(dosyaYolu);
    await ref.delete();
  }
}