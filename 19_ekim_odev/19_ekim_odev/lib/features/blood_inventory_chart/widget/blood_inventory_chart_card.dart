import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/blood_inventory_model.dart';

/// Kan gruplarının doluluk ve stok seviyesini gösteren interaktif grafik kartı.
class BloodInventoryChartCard extends StatelessWidget {
  final List<BloodGroupStock> stocks;
  final String? selectedBloodType;
  final ValueChanged<String> onSelectBloodType;

  const BloodInventoryChartCard({
    super.key,
    required this.stocks,
    required this.selectedBloodType,
    required this.onSelectBloodType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ChartHeader(),
            const SizedBox(height: 16),
            _ChartBarsRow(
              stocks: stocks,
              selectedBloodType: selectedBloodType,
              onSelectBloodType: onSelectBloodType,
            ),
            const SizedBox(height: 12),
            const _ChartLegend(),
          ],
        ),
      ),
    );
  }
}

class _ChartHeader extends StatelessWidget {
  const _ChartHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.bar_chart_rounded,
                color: Theme.of(context).colorScheme.primary, size: 22),
            const SizedBox(width: 8),
            Text(
              'Grup Bazlı Stok Grafiği',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        Text(
          'Tıkla & Seç',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

class _ChartBarsRow extends StatelessWidget {
  final List<BloodGroupStock> stocks;
  final String? selectedBloodType;
  final ValueChanged<String> onSelectBloodType;

  const _ChartBarsRow({
    required this.stocks,
    required this.selectedBloodType,
    required this.onSelectBloodType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: stocks.map((stock) {
          final isSelected = stock.bloodType == selectedBloodType;
          return Expanded(
            child: _ChartBarColumn(
              stock: stock,
              isSelected: isSelected,
              onTap: () => onSelectBloodType(stock.bloodType),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChartBarColumn extends StatelessWidget {
  final BloodGroupStock stock;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChartBarColumn({
    required this.stock,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color barColor = _resolveBarColor(stock, colorScheme);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${stock.percentage}%',
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            _BarVisual(
              fillRatio: stock.fillRatio,
              barColor: barColor,
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),
            _BloodTypeLabel(label: stock.bloodType, isSelected: isSelected),
          ],
        ),
      ),
    );
  }

  Color _resolveBarColor(BloodGroupStock item, ColorScheme scheme) {
    if (item.isCritical) return AppColors.statusCritical;
    if (item.isWarning) return AppColors.statusWarning;
    return scheme.primary;
  }
}

class _BarVisual extends StatelessWidget {
  final double fillRatio;
  final Color barColor;
  final bool isSelected;

  const _BarVisual({
    required this.fillRatio,
    required this.barColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
        border: isSelected
            ? Border.all(color: colorScheme.primary, width: 2)
            : null,
      ),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: fillRatio.clamp(0.08, 1.0),
        widthFactor: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class _BloodTypeLabel extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _BloodTypeLabel({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: isSelected
          ? BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            )
          : null,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendDot(color: AppColors.statusCritical, label: 'Kritik (<25)'),
        const SizedBox(width: 12),
        _LegendDot(color: AppColors.statusWarning, label: 'Düşük (<%50)'),
        const SizedBox(width: 12),
        _LegendDot(
            color: theme.colorScheme.primary, label: 'Yeterli (≥%50)'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
