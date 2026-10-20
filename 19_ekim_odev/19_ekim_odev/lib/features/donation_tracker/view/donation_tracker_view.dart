import 'package:flutter/material.dart';
import '../controller/donation_tracker_controller.dart';
import '../models/donation_tracker_model.dart';
import '../widget/donation_history_tile.dart';
import '../widget/donation_tracker_card.dart';

/// Kullanıcının bağış profilini ve yıllık hedeflerini takip ettiği ana görünüm.
class DonationTrackerView extends StatelessWidget {
  final DonationTrackerController controller;

  const DonationTrackerView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DonorProfile>(
      valueListenable: controller.donorProfileNotifier,
      builder: (context, profile, _) {
        return ValueListenableBuilder<int>(
          valueListenable: controller.currentDonatedUnits,
          builder: (context, currentUnits, _) {
            return ValueListenableBuilder<List<DonationRecord>>(
              valueListenable: controller.historyNotifier,
              builder: (context, history, _) {
                return _TrackerContent(
                  controller: controller,
                  profile: profile,
                  currentUnits: currentUnits,
                  history: history,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _TrackerContent extends StatelessWidget {
  final DonationTrackerController controller;
  final DonorProfile profile;
  final int currentUnits;
  final List<DonationRecord> history;

  const _TrackerContent({
    required this.controller,
    required this.profile,
    required this.currentUnits,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DonorProfileHeader(profile: profile),
          const SizedBox(height: 16),
          DonationTrackerCard(
            title: '2026 Yıllık Bağış Hedefi',
            subtitle: 'Her bağış 3 can kurtarır',
            bloodType: profile.bloodType,
            currentUnits: currentUnits,
            targetUnits: controller.targetUnits,
            fillRatio: controller.fillRatio,
          ),
          const SizedBox(height: 16),
          _ActionButtonsRow(controller: controller),
          const SizedBox(height: 20),
          _HistorySection(history: history),
        ],
      ),
    );
  }
}

class _DonorProfileHeader extends StatelessWidget {
  final DonorProfile profile;

  const _DonorProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${profile.bloodType} • ${profile.healthPoints} Can Puanı',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Gönüllü Donör',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final DonationTrackerController controller;

  const _ActionButtonsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FilledButton.icon(
            onPressed: () => controller.addDonation(
              location: 'Kızılay Kan Alma Merkezi',
            ),
            icon: const Icon(Icons.add_rounded, size: 20),
            label: const Text('1 Ünite Bağış Kaydet'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.resetDonations,
            child: const Text('Sıfırla'),
          ),
        ),
      ],
    );
  }
}

class _HistorySection extends StatelessWidget {
  final List<DonationRecord> history;

  const _HistorySection({required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'Henüz kayıtlı bağış geçmişiniz bulunmuyor.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Son Bağış Hareketleri',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),
        ...history.map((record) => DonationHistoryTile(record: record)),
      ],
    );
  }
}
