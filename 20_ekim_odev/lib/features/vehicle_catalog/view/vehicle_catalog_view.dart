import 'package:flutter/material.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../active_rental/models/active_rental_model.dart';
import '../../active_rental/view/active_rental_view.dart';
import '../../auth_register/models/auth_register_model.dart';
import '../../vehicle_filter/models/vehicle_filter_model.dart';
import '../controller/vehicle_catalog_controller.dart';
import '../models/vehicle_catalog_model.dart';
import '../widget/rental_calculator_sheet.dart';
import '../widget/vehicle_catalog_card.dart';

/// [ÜST AÇIKLAMA]: VehicleCatalogView, kullanıcının seçtiği kriterlere göre filtrelenen
/// araçları listeleyen ve araç seçildiğinde dinamik maliyet hesaplama tabakasını (Bottom Sheet)
/// açan 3. ana ekrandır. 40 satır build sınırına titizlikle uyulmuştur.
class VehicleCatalogView extends StatefulWidget {
  final ThemeController themeController;
  final VehicleFilterModel filter;
  final UserRegisterModel registeredUser;

  const VehicleCatalogView({
    super.key,
    required this.themeController,
    required this.filter,
    required this.registeredUser,
  });

  @override
  State<VehicleCatalogView> createState() => _VehicleCatalogViewState();
}

class _VehicleCatalogViewState extends State<VehicleCatalogView> {
  late final VehicleCatalogController _catalogController;
  late final List<VehicleModel> _filteredVehicles;

  @override
  void initState() {
    super.initState();
    _catalogController = VehicleCatalogController();
    _filteredVehicles = _catalogController.getFilteredVehicles(widget.filter.usageType);
  }

  /// [ÜST AÇIKLAMA]: Araç kartına tıklandığında kiralama hesaplama bottom sheet'ini açar.
  void _openCalculatorSheet(VehicleModel vehicle) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => RentalCalculatorSheet(
        vehicle: vehicle,
        filter: widget.filter,
        controller: _catalogController,
        onConfirm: (rentalType, duration, totalCost) {
          final rentalModel = ActiveRentalModel(
            vehicle: vehicle,
            rentalType: rentalType,
            duration: duration,
            totalCost: totalCost,
            locationScope: widget.filter.locationScope,
            usageType: widget.filter.usageType,
            startTime: DateTime.now(),
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ActiveRentalView(
                themeController: widget.themeController,
                rentalModel: rentalModel,
              ),
            ),
          );
        },
      ),
    );
  }
  // [ALT AÇIKLAMA]: Onaylanan kiralama ActiveRentalModel'e dönüştürülerek 4. sayfaya aktarılır.

  /// [ÜST AÇIKLAMA]: Üst kısımda aktif filtre kriterlerini ve çarpanı gösteren özet çubuk
  Widget _buildFilterBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: colorScheme.surfaceContainerHighest.withAlpha(120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filtre: ${widget.filter.usageType} • ${widget.filter.locationScope}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Badge(
            label: Text('${widget.filter.totalMultiplier.toStringAsFixed(0)}x Çarpan'),
            backgroundColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
  // [ALT AÇIKLAMA]: Kullanıcının önceki sayfada belirlediği kriterleri şeffafça hatırlatır.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.filter.usageType} Araçlar (${_filteredVehicles.length})'),
        actions: [ThemeModeSwitchButton(controller: widget.themeController)],
      ),
      body: Column(
        children: [
          _buildFilterBanner(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredVehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _filteredVehicles[index];
                return VehicleCatalogCard(
                  vehicle: vehicle,
                  onTap: () => _openCalculatorSheet(vehicle),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// [ALT AÇIKLAMA]: VehicleCatalogView, Material 3 standartlarında liste, bottom sheet ve
// diyalog etkileşimlerini pedagojik ve modüler yapıda sunar.
