import 'package:flutter/material.dart';
import 'screens/arac_listesi_ekrani.dart';

void main() {
  runApp(const OtoServisApp());
}

class OtoServisApp extends StatelessWidget {
  const OtoServisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OtoServis Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const AracListesiEkrani(),
    );
  }
}