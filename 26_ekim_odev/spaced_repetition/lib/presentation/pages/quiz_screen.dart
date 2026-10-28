import 'package:flutter/material.dart';
import 'dart:math';
import '../../domain/entities/flashcard.dart';

class QuizScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const QuizScreen({super.key, required this.flashcards});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Flashcard _currentCard;
  late List<String> _options;
  int _score = 0;
  int _questionCount = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    _currentCard = widget.flashcards[random.nextInt(widget.flashcards.length)];

    final allAnswers = widget.flashcards.map((e) => e.backText).toSet().toList();
    allAnswers.remove(_currentCard.backText);
    allAnswers.shuffle();

    _options = [_currentCard.backText];
    _options.addAll(allAnswers.take(3));
    _options.shuffle();

    _isAnswered = false;
    _selectedAnswer = '';
    _questionCount++;
  }

  void _checkAnswer(String answer) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedAnswer = answer;
      if (answer == _currentCard.backText) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _generateQuestion();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.length < 4) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(
          child: Text('Quiz için en az 4 farklı kart eklemelisiniz.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Skor: $_score / ${_questionCount - 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    _currentCard.frontText,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemCount: _options.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final option = _options[index];
                  Color buttonColor = Theme.of(context).colorScheme.surfaceContainerHighest;
                  Color textColor = Colors.black87;

                  if (_isAnswered) {
                    if (option == _currentCard.backText) {
                      buttonColor = Colors.green;
                      textColor = Colors.white;
                    } else if (option == _selectedAnswer) {
                      buttonColor = Colors.red;
                      textColor = Colors.white;
                    }
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _checkAnswer(option),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}