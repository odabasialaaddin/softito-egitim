import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/flashcard_model.dart';
import 'data/repositories/flashcard_repository_impl.dart';
import 'domain/repositories/flashcard_repository.dart';
import 'domain/usecases/review_flashcard_usecase.dart';
import 'presentation/bloc/flashcard_bloc.dart';
import 'presentation/bloc/flashcard_event.dart';
import 'presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardModelAdapter());
  
  final flashcardBox = await Hive.openBox<FlashcardModel>('flashcards');
  
  final flashcardRepository = FlashcardRepositoryImpl(flashcardBox);
  final reviewUseCase = ReviewFlashcardUseCase(flashcardRepository);

  runApp(MyApp(
    repository: flashcardRepository,
    reviewUseCase: reviewUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final FlashcardRepository repository;
  final ReviewFlashcardUseCase reviewUseCase;

  const MyApp({
    super.key,
    required this.repository,
    required this.reviewUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FlashcardBloc>(
          create: (context) => FlashcardBloc(
            repository: repository,
            reviewUseCase: reviewUseCase,
          )..add(LoadFlashcards()),
        ),
      ],
      child: MaterialApp(
        title: 'Spaced Repetition App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}