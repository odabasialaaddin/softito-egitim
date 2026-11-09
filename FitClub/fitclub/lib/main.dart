import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'features/workout/presentation/pages/workout_page.dart'; 

void main() async {
  // 1. Asenkron işlemlerden önce Flutter motorunu güvene alıyoruz.
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Cihazın (iOS/Android) yerel klasör yolunu bulup Hive'ı oraya kuruyoruz.
  await Hive.initFlutter();

  // 3. 'workoutBox' isimli kutumuzu (veritabanını) uygulama ekrana çizilmeden önce açıyoruz.
  await Hive.openBox('workoutBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitClub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Uygulamanın genel tema ayarı
      home: const WorkoutPage(),
    );
  }
}