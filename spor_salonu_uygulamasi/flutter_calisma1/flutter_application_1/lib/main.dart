import 'package:flutter/material.dart';
import 'screens/uye_listesi_ekrani.dart';

void main() {
  runApp(const SporSalonuApp());
}

class SporSalonuApp extends StatelessWidget {
  const SporSalonuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spor Salonu Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const UyeListesiEkrani(),
    );
  }
}