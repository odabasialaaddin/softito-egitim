import 'package:equatable/equatable.dart';
import '../../domain/entities/flashcard.dart';

abstract class FlashcardState extends Equatable {
  const FlashcardState();
  
  @override
  List<Object> get props => [];
}

class FlashcardInitial extends FlashcardState {}

class FlashcardLoading extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final List<Flashcard> flashcards;
  final List<Flashcard> dueFlashcards;

  const FlashcardLoaded({
    required this.flashcards,
    required this.dueFlashcards,
  });

  @override
  List<Object> get props => [flashcards, dueFlashcards];
}

class FlashcardError extends FlashcardState {
  final String message;

  const FlashcardError(this.message);

  @override
  List<Object> get props => [message];
}