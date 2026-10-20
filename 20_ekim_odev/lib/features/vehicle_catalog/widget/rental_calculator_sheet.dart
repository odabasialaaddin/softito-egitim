import 'package:flutter/material.dart';
import '../../vehicle_filter/models/vehicle_filter_model.dart';
import '../controller/vehicle_catalog_controller.dart';
import '../models/vehicle_catalog_model.dart';

/// [ÜST AÇIKLAMA]: RentalCalculatorSheet, kullanıcının seçtiği araç için kiralama tipini
/// (Saatlik/Günlük) ve süreyi girip canlı maliyeti anlık gördüğü Bottom Sheet bileşenidir.
/// Form validasyonu ve onay diyaloğu içerir. 40 satır build sınırına titizlikle uyulmuştur.
class RentalCalculatorSheet extends StatefulWidget {
  final VehicleModel vehicle;
  final VehicleFilterModel filter;
  final VehicleCatalogController controller;
  final void Function(String rentalType, int duration, double totalCost) onConfirm;

  const RentalCalculatorSheet({
    super.key,
    required this.vehicle,
    required this.filter,
    required this.controller,
    required this.onConfirm,
  });

  @override
  State<RentalCalculatorSheet> createState() => _RentalCalculatorSheetState();
}

class _RentalCalculatorSheetState extends State<RentalCalculatorSheet> {
  final GlobalKey<FormState> _sheetFormKey = GlobalKey<FormState>();
  final TextEditingController _durationController = TextEditingController(text: '1');
  final ValueNotifier<String> _rentalTypeNotifier = ValueNotifier<String>('Saatlik');
  final ValueNotifier<double> _liveCostNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _recalculateCost();
  }

  @override
  void dispose() {
    _durationController.dispose();
    _rentalTypeNotifier.dispose();
    _liveCostNotifier.dispose();
    super.dispose();
  }

  /// [ÜST AÇIKLAMA]: Süre veya kiralama tipi değiştikçe toplam maliyeti anlık hesaplar.
  void _recalculateCost() {
    final int duration = int.tryParse(_durationController.text.trim()) ?? 0;
    final cost = widget.controller.calculateRentalCost(
      vehicle: widget.vehicle,
      rentalType: _rentalTypeNotifier.value,
      duration: duration,
      usageMultiplier: widget.filter.usageMultiplier,
      locationMultiplier: widget.filter.locationMultiplier,
    );
    _liveCostNotifier.value = cost;
  }
  // [ALT AÇIKLAMA]: ValueNotifier üzerinden dinleyen widget'lara anlık hesaplanan TL tutarı yansıtılır.

  /// [ÜST AÇIKLAMA]: Kiralama öncesi kullanıcıya özet gösteren onay diyaloğu (AlertDialog)
  Future<void> _showConfirmationDialog() async {
    if (!_sheetFormKey.currentState!.validate()) return;

    final duration = int.parse(_durationController.text.trim());
    final totalCost = _liveCostNotifier.value;
    final rentalType = _rentalTypeNotifier.value;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        icon: const Icon(Icons.car_rental, size: 40, color: Colors.blue),
        title: const Text('Kiralama Özeti ve Onay'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Araç: ${widget.vehicle.brandModel}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('• Şase No: ${widget.vehicle.chassisNo}'),
            Text('• Model Yılı: ${widget.vehicle.modelYear}'),
            Text('• Kapsam: ${widget.filter.usageType} - ${widget.filter.locationScope}'),
            Text('• Süre: $duration ${rentalType == "Saatlik" ? "Saat" : "Gün"}'),
            const Divider(height: 16),
            Text(
              'Toplam Maliyet: ${totalCost.toStringAsFixed(2)} TL',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text('Onayla ve Başlat'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.of(context).pop(); // Bottom sheet'i kapat
      widget.onConfirm(rentalType, duration, totalCost);
    }
  }
  // [ALT AÇIKLAMA]: Kullanıcı onay verirse bottom sheet kapanır ve kiralama akışı başlatılır.

  /// [ÜST AÇIKLAMA]: Saatlik veya Günlük kiralama türünü seçtiren SegmentedButton widget'ı
  Widget _buildTypeSelector(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _rentalTypeNotifier,
      builder: (context, selectedType, _) {
        return SegmentedButton<String>(
          segments: const [
            ButtonSegment(
              value: 'Saatlik',
              label: Text('Saatlik Kiralama'),
              icon: Icon(Icons.access_time),
            ),
            ButtonSegment(
              value: 'Günlük',
              label: Text('Günlük Kiralama'),
              icon: Icon(Icons.calendar_today),
            ),
          ],
          selected: {selectedType},
          onSelectionChanged: (newSelection) {
            _rentalTypeNotifier.value = newSelection.first;
            _recalculateCost();
          },
        );
      },
    );
  }
  // [ALT AÇIKLAMA]: SegmentedButton ile şık Material 3 seçim arabirimi sunulur.

  /// [ÜST AÇIKLAMA]: Süre giriş alanı ve anlık maliyet göstergesi
  Widget _buildDurationAndCost(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder<String>(
      valueListenable: _rentalTypeNotifier,
      builder: (context, type, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                key: const Key('rental_duration_input'),
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: type == 'Saatlik' ? 'Kaç Saat?' : 'Kaç Gün?',
                  prefixIcon: const Icon(Icons.timelapse),
                  suffixText: type == 'Saatlik' ? 'saat' : 'gün',
                ),
                onChanged: (_) => _recalculateCost(),
                validator: (val) {
                  final parsed = int.tryParse(val?.trim() ?? '');
                  if (parsed == null || parsed <= 0) {
                    return 'En az 1 girin.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: ValueListenableBuilder<double>(
                valueListenable: _liveCostNotifier,
                builder: (context, cost, _) {
                  return Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.primary),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${cost.toStringAsFixed(0)} TL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
  // [ALT AÇIKLAMA]: Süre değiştikçe hesaplanan toplam maliyet anında kutucuğa yansır.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _sheetFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.vehicle.brandModel,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'VIN: ${widget.vehicle.chassisNo} • Model: ${widget.vehicle.modelYear}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            _buildTypeSelector(context),
            const SizedBox(height: 16),
            _buildDurationAndCost(context),
            const SizedBox(height: 20),
            FilledButton.icon(
              key: const Key('confirm_rental_sheet_button'),
              onPressed: _showConfirmationDialog,
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text('Kirala'),
            ),
          ],
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: RentalCalculatorSheet, Material 3 standartlarında alt tabaka (Bottom Sheet)
// içinde reaktif hesaplama motorunu ve onay akışını eksiksiz sunar.
