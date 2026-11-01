import 'package:flutter/material.dart';
import '../models/uyelik_tipi.dart';

class UyelikRozeti extends StatelessWidget {
  final UyelikTipi uyelikTipi;
  final bool aktifMi;

  const UyelikRozeti({
    super.key,
    required this.uyelikTipi,
    required this.aktifMi,
  });

  @override
  Widget build(BuildContext context) {
    final anaRenk = aktifMi ? Colors.green.shade700 : Colors.red.shade700;
    final arkaPlanRengi = aktifMi ? Colors.green.shade50 : Colors.red.shade50;
    final durumMetni = aktifMi ? 'Aktif' : 'Pasif' ;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: arkaPlanRengi,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: anaRenk.withValues(alpha: 0.4)),
      ),
      child: Text(
        '${uyelikTipi.baslik} • $durumMetni',
        style: TextStyle(
          color:anaRenk,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}