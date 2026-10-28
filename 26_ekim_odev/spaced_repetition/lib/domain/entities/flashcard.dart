class Flashcard {
  final String id;
  final String frontText;
  final String backText;
  final DateTime nextReviewDate;

  final int repetitionCount;
  final double easeFactor;
  final int interval;

  Flashcard({
    required this.id,
    required this.frontText,
    required this.backText,
    required this.nextReviewDate,
    this.repetitionCount = 0,
    this.easeFactor = 2.5,
    this.interval = 0,
  });
}