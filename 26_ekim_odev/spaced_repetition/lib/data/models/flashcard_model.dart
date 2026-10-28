import 'package:hive/hive.dart';
import '../../domain/entities/flashcard.dart';

part 'flashcard_model.g.dart';

@HiveType(typeId: 0)
class FlashcardModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String frontText;
  
  @HiveField(2)
  final String backText;
  
  @HiveField(3)
  final DateTime nextReviewDate;
  
  @HiveField(4)
  final int repetitionCount;
  
  @HiveField(5)
  final double easeFactor;
  
  @HiveField(6)
  final int interval;

  FlashcardModel({
    required this.id,
    required this.frontText,
    required this.backText,
    required this.nextReviewDate,
    required this.repetitionCount,
    required this.easeFactor,
    required this.interval,
  });

  factory FlashcardModel.fromEntity(Flashcard entity) {
    return FlashcardModel(
      id: entity.id,
      frontText: entity.frontText,
      backText: entity.backText,
      nextReviewDate: entity.nextReviewDate,
      repetitionCount: entity.repetitionCount,
      easeFactor: entity.easeFactor,
      interval: entity.interval,
    );
  }

  Flashcard toEntity() {
    return Flashcard(
      id: id,
      frontText: frontText,
      backText: backText,
      nextReviewDate: nextReviewDate,
      repetitionCount: repetitionCount,
      easeFactor: easeFactor,
      interval: interval,
    );
  }
}