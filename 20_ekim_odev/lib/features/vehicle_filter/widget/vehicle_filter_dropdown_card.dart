import 'package:flutter/material.dart';
import '../controller/vehicle_filter_controller.dart';
import '../models/vehicle_filter_model.dart';

/// [ÜST AÇIKLAMA]: VehicleFilterDropdownCard, kullanıcının kullanım türü ve lokasyon
/// seçimlerini yaptığı 2 adet DropdownButtonFormField ve canlı çarpan özetini barındıran karttır.
/// 40 satır build sınırına titizlikle uyulacak şekilde modüler yapıda geliştirilmiştir.
class VehicleFilterDropdownCard extends StatelessWidget {
  final VehicleFilterController controller;
  final VoidCallback onContinue;

  const VehicleFilterDropdownCard({
    super.key,
    required this.controller,
    required this.onContinue,
  });

  /// [ÜST AÇIKLAMA]: 1. Sorgu olan Şahsi / Ticari kullanım açılır menüsü
  Widget _buildUsageDropdown(BuildContext context, VehicleFilterModel filter) {
    return DropdownButtonFormField<String>(
      key: ValueKey('usage_${filter.usageType}'),
      initialValue: filter.usageType,
      decoration: const InputDecoration(
        labelText: '1- Aracı ticari mi şahsi mi kullanacaksın?',
        helperText: 'Şahsi: 1x çarpan | Ticari: 2x çarpan',
        prefixIcon: Icon(Icons.business_center_outlined),
      ),
      items: VehicleFilterController.usageOptions.map((opt) {
        return DropdownMenuItem<String>(
          value: opt,
          child: Text('$opt Kullanım (${opt == "Şahsi" ? "1x" : "2x"})'),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) controller.setUsageType(val);
      },
    );
  }
  // [ALT AÇIKLAMA]: Kullanıcının şahsi ya da ticari kullanım amacını belirlemesini sağlar.

  /// [ÜST AÇIKLAMA]: 2. Sorgu olan Şehir İçi / Şehir Dışı kullanım açılır menüsü
  Widget _buildLocationDropdown(BuildContext context, VehicleFilterModel filter) {
    return DropdownButtonFormField<String>(
      key: ValueKey('loc_${filter.locationScope}'),
      initialValue: filter.locationScope,
      decoration: const InputDecoration(
        labelText: '2- Aracı şehir içi mi şehir dışı mı kullanacaksın?',
        helperText: 'Şehir İçi: 1x çarpan | Şehir Dışı: 2x çarpan',
        prefixIcon: Icon(Icons.location_city_outlined),
      ),
      items: VehicleFilterController.locationOptions.map((opt) {
        return DropdownMenuItem<String>(
          value: opt,
          child: Text('$opt Sürüş (${opt == "Şehir İçi" ? "1x" : "2x"})'),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) controller.setLocationScope(val);
      },
    );
  }
  // [ALT AÇIKLAMA]: Sürüş lokasyonunu belirler ve fiyat çarpanını dinamik etkiler.

  /// [ÜST AÇIKLAMA]: Seçilen filtrelere göre hesaplanan toplam fiyat çarpanını gösteren özet rozet çubuğu
  Widget _buildMultiplierSummary(BuildContext context, VehicleFilterModel filter) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withAlpha(80)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calculate_outlined, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Toplam Fiyat Çarpanı:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Chip(
            backgroundColor: colorScheme.primary,
            label: Text(
              '${filter.totalMultiplier.toStringAsFixed(0)}x Çarpan',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // [ALT AÇIKLAMA]: Reaktif ValueListenableBuilder ile anlık çarpan durumunu şeffafça kullanıcıya iletir.

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VehicleFilterModel>(
      valueListenable: controller.filterNotifier,
      builder: (context, filter, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildUsageDropdown(context, filter),
                const SizedBox(height: 20),
                _buildLocationDropdown(context, filter),
                const SizedBox(height: 20),
                _buildMultiplierSummary(context, filter),
                const SizedBox(height: 24),
                FilledButton.icon(
                  key: const Key('filter_continue_button'),
                  onPressed: onContinue,
                  icon: const Icon(Icons.search),
                  label: const Text('Devam • Uygun Araçları Gör'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// [ALT AÇIKLAMA]: VehicleFilterDropdownCard, Material Design 3 Chip, Dropdown ve
// FilledButton.icon bileşenlerini temiz bir mimaride bir araya getirir.
