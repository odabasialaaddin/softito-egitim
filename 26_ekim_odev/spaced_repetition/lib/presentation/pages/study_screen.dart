import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import '../../domain/entities/flashcard.dart';
import '../../domain/usecases/review_flashcard_usecase.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/flashcard_event.dart';

class StudyScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const StudyScreen({super.key, required this.flashcards});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  int _currentIndex = 0;
  bool _isFlipped = false;

  void _reviewCard(ReviewQuality quality) {
    final currentCard = widget.flashcards[_currentIndex];
    
    context.read<FlashcardBloc>().add(ReviewFlashcard(
      flashcard: currentCard,
      quality: quality,
    ));

    setState(() {
      _currentIndex++;
      _isFlipped = false;
    });
  }

  Widget _buildCardContent(String text) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.flashcards.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Çalışma Bitti')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bugünlük tüm kartları tamamladın!', 
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ana Ekrana Dön'),
              ),
            ],
          ),
        ),
      );
    }

    final currentCard = widget.flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kart ${_currentIndex + 1} / ${widget.flashcards.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!_isFlipped) {
                    setState(() => _isFlipped = true);
                  }
                },
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: _isFlipped ? 180 : 0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack, // Hafif yaylanma efekti
                  builder: (context, double value, child) {
                    // Kart 90 dereceyi geçtiyse arka yüzünü gösteriyoruz
                    bool isBack = value >= 90;
                    
                    // Dereceyi radyana çeviriyoruz (Matrix4 radyan kullanır)
                    double rotation = value * math.pi / 180;

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // 3D derinlik (perspektif) katar
                        ..rotateY(rotation),    // Y ekseninde döndürür
                      child: isBack
                          // Arka yüz 180 derece döndüğü için yazılar ters (aynalanmış) görünmesin diye içteki içeriği tekrar çeviriyoruz
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _buildCardContent(currentCard.backText),
                            )
                          : _buildCardContent(currentCard.frontText),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (!_isFlipped)
              const Text(
                'Cevabı görmek için karta dokunun', 
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            if (_isFlipped)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _reviewCard(ReviewQuality.forgot),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red.shade900,
                    ),
                    child: const Text('Unutmuşum'),
                  ),
                  ElevatedButton(
                    onPressed: () => _reviewCard(ReviewQuality.hard),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade100,
                      foregroundColor: Colors.orange.shade900,
                    ),
                    child: const Text('Zorlandım'),
                  ),
                  ElevatedButton(
                    onPressed: () => _reviewCard(ReviewQuality.easy),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.green.shade900,
                    ),
                    child: const Text('Çok Kolay'),
                  ),
                ],
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}