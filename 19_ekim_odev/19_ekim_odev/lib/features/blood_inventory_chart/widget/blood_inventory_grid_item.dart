import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/blood_inventory_model.dart';

/// Tek bir kan grubuna ait stok ayrıntısını ve hızlı aksiyonları gösteren kart.
class BloodInventoryGridItem extends StatelessWidget {
  final BloodGroupStock stock;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const BloodInventoryGridItem({
    super.key,
    required this.stock,
    required this.isSelected,
    required this.onTap,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HeaderSection(stock: stock),
              _ProgressSection(stock: stock),
              _ActionsSection(onAdd: onAdd, onRemove: onRemove),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final BloodGroupStock stock;

  const _HeaderSection({required this.stock});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          stock.bloodType,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        _StatusChip(stock: stock),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final BloodGroupStock stock;

  const _StatusChip({required this.stock});

  @override
  Widget build(BuildContext context) {
    final Color color = _getStatusColor(stock);
    final String label = _getStatusLabel(stock);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(BloodGroupStock item) {
    if (item.isCritical) return AppColors.statusCritical;
    if (item.isWarning) return AppColors.statusWarning;
    return AppColors.statusOptimal;
  }

  String _getStatusLabel(BloodGroupStock item) {
    if (item.isCritical) return 'KRİTİK';
    if (item.isWarning) return 'DÜŞÜK';
    return 'GÜVENLİ';
  }
}

class _ProgressSection extends StatelessWidget {
  final BloodGroupStock stock;

  const _ProgressSection({required this.stock});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${stock.currentUnits} Ünite',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              'Hedef: ${stock.targetUnits}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: stock.fillRatio,
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: colorScheme.surfaceContainerHighest,
          color: stock.isCritical ? AppColors.statusCritical : colorScheme.primary,
        ),
      ],
    );
  }
}

class _ActionsSection extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _ActionsSection({required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onRemove,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 30),
              visualDensity: VisualDensity.compact,
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton(
            onPressed: onAdd,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 30),
              visualDensity: VisualDensity.compact,
            ),
            child: const Icon(Icons.add, size: 16),
          ),
        ),
      ],
    );
  }
}
