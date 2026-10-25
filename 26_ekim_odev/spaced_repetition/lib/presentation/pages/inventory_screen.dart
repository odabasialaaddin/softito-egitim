import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/flashcard_event.dart';
import '../bloc/flashcard_state.dart';
import 'edit_card_screen.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kart Envanteri'),
      ),
      body: BlocBuilder<FlashcardBloc, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FlashcardLoaded) {
            final cards = state.flashcards;

            if (cards.isEmpty) {
              return const Center(child: Text('Henüz kart eklenmemiş.'));
            }

            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];

                return Dismissible(
                  key: Key(card.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    context.read<FlashcardBloc>().add(DeleteFlashcard(card.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kart silindi')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCardScreen(flashcard: card),
                          ),
                        );
                      },
                      title: Text(
                        card.frontText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(card.backText),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Seviye: ${card.repetitionCount}'),
                          Text(
                            'Çarpan: ${card.easeFactor.toStringAsFixed(1)}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}