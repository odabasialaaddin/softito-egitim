import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/blood_inventory_controller.dart';
import '../models/blood_inventory_model.dart';
import '../widget/blood_inventory_chart_card.dart';
import '../widget/blood_inventory_grid_item.dart';

/// Kan gruplarının grafiksel stok takibini ve yönetimini sağlayan ana görünüm.
class BloodInventoryView extends StatelessWidget {
  final BloodInventoryController controller;

  const BloodInventoryView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BloodGroupStock>>(
      valueListenable: controller.stocksNotifier,
      builder: (context, stocks, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: controller.selectedBloodTypeNotifier,
          builder: (context, selectedType, _) {
            return _InventoryContent(
              controller: controller,
              stocks: stocks,
              selectedType: selectedType,
            );
          },
        );
      },
    );
  }
}

class _InventoryContent extends StatelessWidget {
  final BloodInventoryController controller;
  final List<BloodGroupStock> stocks;
  final String? selectedType;

  const _InventoryContent({
    required this.controller,
    required this.stocks,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OverviewStatsRow(controller: controller),
          const SizedBox(height: 16),
          BloodInventoryChartCard(
            stocks: stocks,
            selectedBloodType: selectedType,
            onSelectBloodType: controller.selectBloodType,
          ),
          const SizedBox(height: 16),
          _GridSectionHeader(
            selectedType: selectedType,
            onClearFilter: () => controller.selectBloodType(null),
          ),
          const SizedBox(height: 12),
          _StocksGrid(
            stocks: stocks,
            selectedType: selectedType,
            controller: controller,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _OverviewStatsRow extends StatelessWidget {
  final BloodInventoryController controller;

  const _OverviewStatsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatMiniCard(
            title: 'Toplam Stok',
            value: '${controller.totalUnits}',
            suffix: 'Ünite',
            icon: Icons.water_drop_rounded,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatMiniCard(
            title: 'Kritik Seviye',
            value: '${controller.criticalGroupCount}',
            suffix: 'Grup',
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.statusCritical,
          ),
        ),
      ],
    );
  }
}

class _StatMiniCard extends StatelessWidget {
  final String title;
  final String value;
  final String suffix;
  final IconData icon;
  final Color iconColor;

  const _StatMiniCard({
    required this.title,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                RichText(
                  text: TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: ' $suffix',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GridSectionHeader extends StatelessWidget {
  final String? selectedType;
  final VoidCallback onClearFilter;

  const _GridSectionHeader({
    required this.selectedType,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tüm Kan Grupları Detayı',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        if (selectedType != null)
          TextButton.icon(
            onPressed: onClearFilter,
            icon: const Icon(Icons.close, size: 14),
            label: Text('$selectedType Filtresini Kaldır'),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              textStyle: const TextStyle(fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class _StocksGrid extends StatelessWidget {
  final List<BloodGroupStock> stocks;
  final String? selectedType;
  final BloodInventoryController controller;

  const _StocksGrid({
    required this.stocks,
    required this.selectedType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stocks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        final isSelected = stock.bloodType == selectedType;

        return BloodInventoryGridItem(
          stock: stock,
          isSelected: isSelected,
          onTap: () => controller.selectBloodType(stock.bloodType),
          onAdd: () => controller.addUnits(stock.bloodType, 1),
          onRemove: () => controller.removeUnits(stock.bloodType, 1),
        );
      },
    );
  }
}
