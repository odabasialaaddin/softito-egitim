import 'package:flutter/material.dart';
import '../models/uye_kaydi.dart';
import 'uyelik_rozeti.dart';

class UyeKarti extends StatelessWidget {
  final UyeKaydi uye;
  final VoidCallback? onTap;

  const UyeKarti({
    super.key,
    required this.uye,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Hero(
          tag: 'uye-avatar-${uye.id}',
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            child: Text(
              uye.adSoyad.isNotEmpty ? uye.adSoyad[0].toUpperCase() : '?',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          uye.adSoyad,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${uye.yas} Yaş • ${uye.telefon}'),
        trailing: UyelikRozeti(
          uyelikTipi: uye.uyelikTipi,
          aktifMi: uye.aktifMi,
        ),
      ),
    );
  }
}