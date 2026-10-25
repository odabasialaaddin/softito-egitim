import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../../domain/usecases/review_flashcard_usecase.dart';
import 'flashcard_event.dart';
import 'flashcard_state.dart';

class _UpdateFlashcardsList extends FlashcardEvent {
  final List<Flashcard> flashcards;
  
  const _UpdateFlashcardsList(this.flashcards);
  
  @override
  List<Object> get props => [flashcards];
}

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  final FlashcardRepository repository;
  final ReviewFlashcardUseCase reviewUseCase;
  StreamSubscription? _flashcardsSubscription;

  FlashcardBloc({
    required this.repository,
    required this.reviewUseCase,
  }) : super(FlashcardInitial()) {
    on<LoadFlashcards>(_onLoadFlashcards);
    on<_UpdateFlashcardsList>(_onUpdateFlashcardsList);
    on<AddFlashcard>(_onAddFlashcard);
    on<UpdateFlashcard>(_onUpdateFlashcard);
    on<DeleteFlashcard>(_onDeleteFlashcard);
    on<ReviewFlashcard>(_onReviewFlashcard);

    _flashcardsSubscription = repository.getFlashcards().listen((flashcards) {
      add(_UpdateFlashcardsList(flashcards));
    });
  }

  Future<void> _onLoadFlashcards(LoadFlashcards event, Emitter<FlashcardState> emit) async {
    emit(FlashcardLoading());
    try {
      final now = DateTime.now();
      final dueFlashcards = await repository.getDueFlashcards(now);
      emit(FlashcardLoaded(flashcards: const [], dueFlashcards: dueFlashcards));
    } catch (e) {
      emit(FlashcardError(e.toString()));
    }
  }

  Future<void> _onUpdateFlashcardsList(_UpdateFlashcardsList event, Emitter<FlashcardState> emit) async {
    final now = DateTime.now();
    final dueFlashcards = await repository.getDueFlashcards(now);
    emit(FlashcardLoaded(flashcards: event.flashcards, dueFlashcards: dueFlashcards));
  }

  Future<void> _onAddFlashcard(AddFlashcard event, Emitter<FlashcardState> emit) async {
    await repository.addFlashcard(event.flashcard);
  }

  Future<void> _onUpdateFlashcard(UpdateFlashcard event, Emitter<FlashcardState> emit) async {
    await repository.updateFlashcard(event.flashcard);
  }

  Future<void> _onDeleteFlashcard(DeleteFlashcard event, Emitter<FlashcardState> emit) async {
    await repository.deleteFlashcard(event.id);
  }

  Future<void> _onReviewFlashcard(ReviewFlashcard event, Emitter<FlashcardState> emit) async {
    await reviewUseCase.execute(event.flashcard, event.quality);
  }

  @override
  Future<void> close() {
    _flashcardsSubscription?.cancel();
    return super.close();
  }
}