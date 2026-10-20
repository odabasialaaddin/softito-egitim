import 'package:flutter/material.dart';
import '../models/donation_tracker_model.dart';

/// Geçmiş bağış kaydını şık bir kart içinde listeleyen widget.
class DonationHistoryTile extends StatelessWidget {
  final DonationRecord record;

  const DonationHistoryTile({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            _RecordBadge(bloodType: record.bloodType),
            const SizedBox(width: 12),
            Expanded(
              child: _RecordDetails(
                location: record.location,
                date: record.date,
              ),
            ),
            Text(
              '+${record.units} Ünite',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordBadge extends StatelessWidget {
  final String bloodType;

  const _RecordBadge({required this.bloodType});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          Icons.favorite_rounded,
          color: colorScheme.primary,
          size: 20,
        ),
      ),
    );
  }
}

class _RecordDetails extends StatelessWidget {
  final String location;
  final String date;

  const _RecordDetails({required this.location, required this.date});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          location,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          date,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}
