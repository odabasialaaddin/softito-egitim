import 'package:equatable/equatable.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/usecases/review_flashcard_usecase.dart';

abstract class FlashcardEvent extends Equatable {
  const FlashcardEvent();

  @override
  List<Object> get props => [];
}

class LoadFlashcards extends FlashcardEvent {}

class AddFlashcard extends FlashcardEvent {
  final Flashcard flashcard;

  const AddFlashcard(this.flashcard);

  @override
  List<Object> get props => [flashcard];
}

class UpdateFlashcard extends FlashcardEvent {
  final Flashcard flashcard;

  const UpdateFlashcard(this.flashcard);

  @override
  List<Object> get props => [flashcard];
}

class DeleteFlashcard extends FlashcardEvent {
  final String id;

  const DeleteFlashcard(this.id);

  @override
  List<Object> get props => [id];
}

class ReviewFlashcard extends FlashcardEvent {
  final Flashcard flashcard;
  final ReviewQuality quality;

  const ReviewFlashcard({
    required this.flashcard,
    required this.quality,
  });

  @override
  List<Object> get props => [flashcard, quality];
}