import '../entities/flashcard.dart';
import '../repositories/flashcard_repository.dart';

enum ReviewQuality { easy, hard, forgot }

class ReviewFlashcardUseCase {
  final FlashcardRepository repository;

  ReviewFlashcardUseCase(this.repository);

  Future<void> execute(Flashcard flashcard, ReviewQuality quality) async {
    int repetition = flashcard.repetitionCount;
    double easeFactor = flashcard.easeFactor;
    int interval = flashcard.interval;

    if (quality == ReviewQuality.forgot) {
      repetition = 0;
      interval = 1;
    } else {
      int qualityScore = quality == ReviewQuality.easy ? 5 : 3;
      
      easeFactor = easeFactor + (0.1 - (5 - qualityScore) * (0.08 + (5 - qualityScore) * 0.02));
      if (easeFactor < 1.3) easeFactor = 1.3;

      if (repetition == 0) {
        interval = 1;
      } else if (repetition == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      repetition++;
    }

    final updatedCard = Flashcard(
      id: flashcard.id,
      frontText: flashcard.frontText,
      backText: flashcard.backText,
      nextReviewDate: DateTime.now().add(Duration(days: interval)),
      repetitionCount: repetition,
      easeFactor: easeFactor,
      interval: interval,
    );

    await repository.updateFlashcard(updatedCard);
  }
}