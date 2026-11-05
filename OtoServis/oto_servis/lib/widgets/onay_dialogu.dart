import 'package:flutter/material.dart';

class OnayDialogu extends StatelessWidget {
  final String baslik;
  final String icerik;

  const OnayDialogu({
    super.key,
    required this.baslik,
    required this.icerik,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(baslik),
      content: Text(icerik),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Sil'),
        ),
      ],
    );
  }
}