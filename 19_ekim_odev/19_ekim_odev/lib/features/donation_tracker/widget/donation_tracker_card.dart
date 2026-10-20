import 'package:flutter/material.dart';

/// Bireysel bağış hedefini ve doluluk oranını gösteren grafiksel ilerleme kartı.
class DonationTrackerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String bloodType;
  final int currentUnits;
  final int targetUnits;
  final double fillRatio;

  const DonationTrackerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.bloodType,
    required this.currentUnits,
    required this.targetUnits,
    required this.fillRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TrackerCardHeader(
              title: title,
              subtitle: subtitle,
              bloodType: bloodType,
            ),
            const SizedBox(height: 16),
            _TrackerProgressBar(fillRatio: fillRatio),
            const SizedBox(height: 12),
            _TrackerFooterInfo(
              bloodType: bloodType,
              currentUnits: currentUnits,
              targetUnits: targetUnits,
              fillRatio: fillRatio,
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackerCardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String bloodType;

  const _TrackerCardHeader({
    required this.title,
    required this.subtitle,
    required this.bloodType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            bloodType,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _TrackerProgressBar extends StatelessWidget {
  final double fillRatio;

  const _TrackerProgressBar({required this.fillRatio});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LinearProgressIndicator(
      value: fillRatio.clamp(0.0, 1.0),
      minHeight: 14,
      backgroundColor: colorScheme.surfaceContainerHighest,
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(8),
    );
  }
}

class _TrackerFooterInfo extends StatelessWidget {
  final String bloodType;
  final int currentUnits;
  final int targetUnits;
  final double fillRatio;

  const _TrackerFooterInfo({
    required this.bloodType,
    required this.currentUnits,
    required this.targetUnits,
    required this.fillRatio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$currentUnits / $targetUnits Ünite Tamamlandı',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '%${(fillRatio * 100).toInt()} Başarı Oranı',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
