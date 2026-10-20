import 'package:flutter/material.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../controller/active_rental_controller.dart';
import '../models/active_rental_model.dart';
import '../widget/active_rental_timer_card.dart';

/// [ÜST AÇIKLAMA]: ActiveRentalView, kiralanan aracın canlı geri sayım sayacını
/// ve araç detaylarını kullanıcıya sunan 4. ana ekrandır.
/// Teslim onayı alındığında sayacı durdurur ve ana sayfaya döner. 40 satır build sınırına uygundur.
class ActiveRentalView extends StatefulWidget {
  final ThemeController themeController;
  final ActiveRentalModel rentalModel;

  const ActiveRentalView({
    super.key,
    required this.themeController,
    required this.rentalModel,
  });

  @override
  State<ActiveRentalView> createState() => _ActiveRentalViewState();
}

class _ActiveRentalViewState extends State<ActiveRentalView> {
  late final ActiveRentalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ActiveRentalController();
    _controller.startCountdown(widget.rentalModel.totalSeconds);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// [ÜST AÇIKLAMA]: Araç teslim onay diyaloğu. Yanlışlıkla basmaları önlemek için AlertDialog açar.
  Future<void> _handleVehicleDelivery() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, size: 44, color: Colors.amber),
        title: const Text('Aracı Teslim Et'),
        content: const Text(
          'Kiralama sürenizi sonlandırıp aracı teslim etmek istediğinize emin misiniz?',
          textAlign: TextAlign.center,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('İptal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text('Evet, Teslim Et'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      _controller.stopAndDeliverVehicle();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Araç başarıyla teslim edildi! Ana sayfaya yönlendiriliyorsunuz.'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
  // [ALT AÇIKLAMA]: Teslim onaylandığında timer durdurulur, SnackBar bildirimi verilir ve ilk sayfaya dönülür.

  /// [ÜST AÇIKLAMA]: Canlı sürüş durumunu gösteren bilgi başlığı kartı
  Widget _buildStatusHeader(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.green.withAlpha(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.green, width: 0.8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Kiralama Aktif • İyi Yolculuklar Dileriz!',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // [ALT AÇIKLAMA]: Sürüşün sorunsuz devam ettiğini yeşil durum ikonuyla gösterir.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktif Kiralama'),
        actions: [
          ThemeModeSwitchButton(controller: widget.themeController),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusHeader(context),
              const SizedBox(height: 16),
              ActiveRentalTimerCard(
                rentalModel: widget.rentalModel,
                controller: _controller,
                onDeliverPressed: _handleVehicleDelivery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: ActiveRentalView, canlı süreyi takip edip aracı teslim etme sürecini
// güvenli diyalog ve SnackBar geri bildirimleriyle tamamlar.
