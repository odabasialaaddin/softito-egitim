import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/urgent_request_model.dart';

/// Tek bir acil kan talebini detayları ve aksiyon butonu ile gösteren kart.
class UrgentRequestCard extends StatelessWidget {
  final UrgentRequest request;
  final VoidCallback onFulfill;

  const UrgentRequestCard({
    super.key,
    required this.request,
    required this.onFulfill,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: request.isUrgent
              ? AppColors.statusCritical.withValues(alpha: 0.5)
              : Theme.of(context).colorScheme.outline,
          width: request.isUrgent ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RequestCardHeader(request: request),
            const SizedBox(height: 12),
            _RequestLocationInfo(request: request),
            const SizedBox(height: 12),
            _RequestProgressBar(request: request),
            const SizedBox(height: 12),
            _RequestActionRow(request: request, onFulfill: onFulfill),
          ],
        ),
      ),
    );
  }
}

class _RequestCardHeader extends StatelessWidget {
  final UrgentRequest request;

  const _RequestCardHeader({required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.statusCritical.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                request.bloodType,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.statusCritical,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (request.isUrgent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusCritical,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'ACİL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Text(
          request.createdAt,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}

class _RequestLocationInfo extends StatelessWidget {
  final UrgentRequest request;

  const _RequestLocationInfo({required this.request});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          request.hospitalName,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on_outlined,
                size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              '${request.city} • Hasta: ${request.patientName}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        if (request.notes.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            request.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ],
    );
  }
}

class _RequestProgressBar extends StatelessWidget {
  final UrgentRequest request;

  const _RequestProgressBar({required this.request});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${request.fulfilledUnits} / ${request.requiredUnits} Ünite Karşılandı',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              request.isCompleted
                  ? 'Tamamlandı'
                  : '${request.remainingUnits} Ünite Kaldı',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: request.isCompleted
                    ? AppColors.statusOptimal
                    : AppColors.statusCritical,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: request.fillRatio,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: colorScheme.surfaceContainerHighest,
          color: request.isCompleted
              ? AppColors.statusOptimal
              : AppColors.statusCritical,
        ),
      ],
    );
  }
}

class _RequestActionRow extends StatelessWidget {
  final UrgentRequest request;
  final VoidCallback onFulfill;

  const _RequestActionRow({required this.request, required this.onFulfill});

  @override
  Widget build(BuildContext context) {
    if (request.isCompleted) {
      return Center(
        child: Text(
          'Bu talep başarıyla karşılandı ✓',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.statusOptimal,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onFulfill,
        icon: const Icon(Icons.volunteer_activism_rounded, size: 18),
        label: const Text('1 Ünite Destek Ol'),
        style: FilledButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
