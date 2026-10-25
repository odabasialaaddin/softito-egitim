import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/flashcard.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/flashcard_event.dart';

class EditCardScreen extends StatefulWidget {
  final Flashcard flashcard;

  const EditCardScreen({super.key, required this.flashcard});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _frontController;
  late TextEditingController _backController;

  @override
  void initState() {
    super.initState();
    // Mevcut kartın verilerini metin kutularına dolduruyoruz
    _frontController = TextEditingController(text: widget.flashcard.frontText);
    _backController = TextEditingController(text: widget.flashcard.backText);
  }

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
    super.dispose();
  }

  void _updateCard() {
    if (_formKey.currentState!.validate()) {
      // Sadece metinleri güncelleyip, algoritma verilerini sabit tutuyoruz
      final updatedCard = Flashcard(
        id: widget.flashcard.id,
        frontText: _frontController.text,
        backText: _backController.text,
        nextReviewDate: widget.flashcard.nextReviewDate,
        repetitionCount: widget.flashcard.repetitionCount,
        easeFactor: widget.flashcard.easeFactor,
        interval: widget.flashcard.interval,
      );

      context.read<FlashcardBloc>().add(UpdateFlashcard(updatedCard));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartı Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _frontController,
                decoration: const InputDecoration(
                  labelText: 'Ön Yüz (Soru / Kelime)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _backController,
                decoration: const InputDecoration(
                  labelText: 'Arka Yüz (Cevap / Açıklama)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateCard,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Güncelle', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}