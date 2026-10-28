import 'dart:async';
import 'package:hive/hive.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../models/flashcard_model.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final Box<FlashcardModel> flashcardBox;
  final _flashcardStreamController = StreamController<List<Flashcard>>.broadcast();

  FlashcardRepositoryImpl(this.flashcardBox) {
    _updateStream();
  }

  void _updateStream() {
    final flashcards = flashcardBox.values.map((model) => model.toEntity()).toList();
    _flashcardStreamController.add(flashcards);
  }

  @override
  Stream<List<Flashcard>> getFlashcards() {
    return _flashcardStreamController.stream;
  }

  @override
  Future<List<Flashcard>> getDueFlashcards(DateTime date) async {
    final allCards = flashcardBox.values.map((model) => model.toEntity()).toList();
    
    return allCards.where((card) {
      return card.nextReviewDate.isBefore(date) || card.nextReviewDate.isAtSameMomentAs(date);
    }).toList();
  }

  @override
  Future<void> addFlashcard(Flashcard flashcard) async {
    final model = FlashcardModel.fromEntity(flashcard);
    await flashcardBox.put(model.id, model);
    _updateStream();
  }

  @override
  Future<void> updateFlashcard(Flashcard flashcard) async {
    final model = FlashcardModel.fromEntity(flashcard);
    await flashcardBox.put(model.id, model);
    _updateStream();
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    await flashcardBox.delete(id);
    _updateStream();
  }
  
  void dispose() {
    _flashcardStreamController.close();
  }
}