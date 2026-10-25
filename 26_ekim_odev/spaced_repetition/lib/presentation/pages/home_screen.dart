import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/flashcard_state.dart';
import 'add_card_screen.dart';
import 'study_screen.dart';
import 'inventory_screen.dart';
import 'quiz_screen.dart'; // Quiz ekranı import edildi

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spaced Repetition'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory_2_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InventoryScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FlashcardBloc, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          if (state is FlashcardError) {
            return Center(child: Text('Hata: ${state.message}'));
          }

          if (state is FlashcardLoaded) {
            final totalCards = state.flashcards.length;
            final dueCards = state.dueFlashcards.length;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'İstatistikler',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text('Toplam Kart: $totalCards', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(
                            'Bugün Tekrar Edilecek: $dueCards',
                            style: TextStyle(
                              fontSize: 18,
                              color: dueCards > 0 ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: dueCards > 0 ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudyScreen(flashcards: state.dueFlashcards),
                        ),
                      );
                    } : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Çalışmaya Başla', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: totalCards >= 4 ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(flashcards: state.flashcards),
                        ),
                      );
                    } : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    child: const Text('Kendini Test Et (Quiz)', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Kart bulunamadı.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCardScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}