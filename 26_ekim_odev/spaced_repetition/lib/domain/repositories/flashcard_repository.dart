import '../entities/flashcard.dart';

abstract class FlashcardRepository {
  Stream<List<Flashcard>> getFlashcards();
  Future<List<Flashcard>> getDueFlashcards(DateTime date);
  Future<void> addFlashcard(Flashcard flashcard);
  Future<void> updateFlashcard(Flashcard flashcard);
  Future<void> deleteFlashcard(String id);
}