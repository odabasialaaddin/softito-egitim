import 'package:flutter/material.dart';
import '../models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: VehicleCatalogCard, katalogdaki bir aracı ve teknik detaylarını
/// (Şase no, Model yılı, Yakıt, Şanzıman, Baz Ücret) Material 3 Card ve InkWell
/// etkileşimiyle gösteren modüler kart bileşenidir. 40 satır build sınırına titizlikle uyulmuştur.
class VehicleCatalogCard extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback onTap;

  const VehicleCatalogCard({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  /// [ÜST AÇIKLAMA]: Araç başlığını ve model yılını gösteren üst başlık satırı
  Widget _buildCardHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            vehicle.usageType == 'Ticari'
                ? Icons.local_shipping_outlined
                : Icons.directions_car_outlined,
            color: colorScheme.onPrimaryContainer,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vehicle.brandModel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                'Yıl: ${vehicle.modelYear} • Şase: ${vehicle.chassisNo}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: 0.5,
                      fontFamily: 'monospace',
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // [ALT AÇIKLAMA]: 17 haneli şase no ve araç kategorisine göre uygun ikon ve tipografi sunar.

  /// [ÜST AÇIKLAMA]: Yakıt, şanzıman ve baz ücret bilgilerini gösteren alt rozet ve fiyat satırı
  Widget _buildCardFooter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: 6,
          children: [
            Chip(
              visualDensity: VisualDensity.compact,
              label: Text(vehicle.fuelType, style: const TextStyle(fontSize: 11)),
              padding: EdgeInsets.zero,
            ),
            Chip(
              visualDensity: VisualDensity.compact,
              label: Text(vehicle.transmission, style: const TextStyle(fontSize: 11)),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${vehicle.baseHourlyRate.toStringAsFixed(0)} TL / saat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 13,
              ),
            ),
            Text(
              '${vehicle.baseDailyRate.toStringAsFixed(0)} TL / gün',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
  // [ALT AÇIKLAMA]: Saatlik ve günlük baz ücretler ayrıştırılarak kullanıcıya net sunulur.

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCardHeader(context),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _buildCardFooter(context),
            ],
          ),
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: VehicleCatalogCard, InkWell dokunma animasyonu ve Material 3 kart yapısıyla
// temiz ve erişilebilir bir araç listeleme deneyimi sunar.
