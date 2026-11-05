import 'package:flutter/material.dart';
import '../models/tamir_durumu.dart';

class DurumSeciciAlani extends StatelessWidget {
  final TamirDurumu seciliDurum;
  final ValueChanged<TamirDurumu> onChanged;

  const DurumSeciciAlani({
    super.key,
    required this.seciliDurum,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tamir Durumu',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: TamirDurumu.values.map((durum) {
            final seciliMi = durum == seciliDurum;

            return ChoiceChip(
              label: Text(durum.baslik),
              selected: seciliMi,
              selectedColor: durum.renk.withOpacity(0.25),
              labelStyle: TextStyle(
                color: seciliMi ? durum.renk : Colors.black87,
                fontWeight: seciliMi ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (bool selected) {
                if (selected) {
                  onChanged(durum);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}