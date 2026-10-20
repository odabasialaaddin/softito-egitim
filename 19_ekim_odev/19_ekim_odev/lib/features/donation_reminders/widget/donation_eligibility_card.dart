import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Donörün biyolojik yenilenme sürecini ve kalan gün sayısını gösteren durum kartı.
class DonationEligibilityCard extends StatelessWidget {
  final int daysLeft;
  final int totalIntervalDays;

  const DonationEligibilityCard({
    super.key,
    required this.daysLeft,
    this.totalIntervalDays = 90,
  });

  double get progressRatio =>
      ((totalIntervalDays - daysLeft) / totalIntervalDays).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EligibilityHeader(daysLeft: daysLeft),
            const SizedBox(height: 14),
            _EligibilityProgressBar(ratio: progressRatio),
            const SizedBox(height: 10),
            _EligibilityTip(daysLeft: daysLeft),
          ],
        ),
      ),
    );
  }
}

class _EligibilityHeader extends StatelessWidget {
  final int daysLeft;

  const _EligibilityHeader({required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.medicalMint.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.health_and_safety_outlined,
                color: AppColors.medicalMint,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bağış Uygunluk Durumu',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Biyolojik Hücre Yenilenmesi',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
        Text(
          '$daysLeft Gün',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.medicalMint,
          ),
        ),
      ],
    );
  }
}

class _EligibilityProgressBar extends StatelessWidget {
  final double ratio;

  const _EligibilityProgressBar({required this.ratio});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        LinearProgressIndicator(
          value: ratio,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: colorScheme.surfaceContainerHighest,
          color: AppColors.medicalMint,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Son Bağış: 66 gün önce',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '%${(ratio * 100).toInt()} Tamamlandı',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.medicalMint,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EligibilityTip extends StatelessWidget {
  final int daysLeft;

  const _EligibilityTip({required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$daysLeft gün sonra en yakın bağış merkezinde yeniden güvenle kan verebilirsiniz.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
