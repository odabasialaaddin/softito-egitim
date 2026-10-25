import 'package:flutter/material.dart';
import '../controller/active_rental_controller.dart';
import '../models/active_rental_model.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalTimerCard, aktif kiralanan aracın saniye hassasiyetindeki
/// canlı geri sayım sayacını ve araç özet bilgilerini gösteren modüler kart bileşenidir.
/// 40 satır build kuralına tam uyum sağlamak için yardımcı widget metotlarına bölünmüştür.
class ActiveRentalTimerCard extends StatelessWidget {
  final ActiveRentalModel rentalModel;
  final ActiveRentalController controller;
  final VoidCallback onDeliverPressed;

  const ActiveRentalTimerCard({
    super.key,
    required this.rentalModel,
    required this.controller,
    required this.onDeliverPressed,
  });

  /// [ÜST AÇIKLAMA]: Dijital gösterge paneli görünümünde canlı sayacı oluşturan bileşen
  Widget _buildDigitalCounter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withAlpha(120), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, color: colorScheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Kalan Kullanım Hakkı',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<int>(
            valueListenable: controller.remainingSeconds,
            builder: (context, seconds, _) {
              return Text(
                ActiveRentalController.formatDuration(seconds),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontFamily: 'monospace',
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
  // [ALT AÇIKLAMA]: ValueListenableBuilder ile saniyelik güncellemeler sadece sayaç metnini etkiler.

  /// [ÜST AÇIKLAMA]: Kiralanan aracın marka, şase, yıl ve toplam ücret detay tablosu
  Widget _buildVehicleDetailsList(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Marka & Model:', rentalModel.vehicle.brandModel),
        const SizedBox(height: 8),
        _buildDetailRow(context, 'Şase No (VIN):', rentalModel.vehicle.chassisNo),
        const SizedBox(height: 8),
        _buildDetailRow(context, 'Model Yılı:', '${rentalModel.vehicle.modelYear}'),
        const SizedBox(height: 8),
        _buildDetailRow(context, 'Kiralama Tipi:', '${rentalModel.duration} ${rentalModel.rentalType} (${rentalModel.locationScope})'),
        const Divider(height: 20),
        _buildDetailRow(
          context,
          'Toplam Ücret:',
          '${rentalModel.totalCost.toStringAsFixed(2)} TL',
          isHighlighted: true,
        ),
      ],
    );
  }
  // [ALT AÇIKLAMA]: Sözleşme parametrelerini açıkça listeler.

  /// [ÜST AÇIKLAMA]: Tekil bilgi satırı üreten yardımcı metot
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: TextStyle(
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
            fontSize: isHighlighted ? 16 : 14,
            color: isHighlighted ? colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
  // [ALT AÇIKLAMA]: Satır bazlı etiket-değer hiyerarşisi oluşturur.

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDigitalCounter(context),
            const SizedBox(height: 20),
            _buildVehicleDetailsList(context),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const Key('deliver_vehicle_button'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
              ),
              onPressed: onDeliverPressed,
              icon: const Icon(Icons.key_off),
              label: const Text('Aracı Teslim Et'),
            ),
          ],
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: ActiveRentalTimerCard, otomotiv konsolu hissi veren dijital sayaç kutusu
// ve teslim butonuyla son derece profesyonel bir görünüm sunar.
