import 'package:flutter/material.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../auth_register/models/auth_register_model.dart';
import '../../vehicle_catalog/view/vehicle_catalog_view.dart';
import '../controller/vehicle_filter_controller.dart';
import '../widget/vehicle_filter_dropdown_card.dart';

/// [ÜST AÇIKLAMA]: VehicleFilterView, kiralama kriterlerinin (Şahsi/Ticari ve Şehir İçi/Dışı)
/// belirlendiği 2. ana ekrandır. Seçilen kriterlere göre fiyat çarpanı hesaplanır ve
/// kullanıcı araç katalog ekranına yönlendirilir. 40 satır kuralına uygun yazılmıştır.
class VehicleFilterView extends StatefulWidget {
  final ThemeController themeController;
  final UserRegisterModel registeredUser;

  const VehicleFilterView({
    super.key,
    required this.themeController,
    required this.registeredUser,
  });

  @override
  State<VehicleFilterView> createState() => _VehicleFilterViewState();
}

class _VehicleFilterViewState extends State<VehicleFilterView> {
  late final VehicleFilterController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = VehicleFilterController();
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  /// [ÜST AÇIKLAMA]: "Devam" butonuna basıldığında filtre verisiyle araç katalog ekranına geçişi sağlar.
  void _navigateToCatalog() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VehicleCatalogView(
          themeController: widget.themeController,
          filter: _filterController.currentFilter,
          registeredUser: widget.registeredUser,
        ),
      ),
    );
  }
  // [ALT AÇIKLAMA]: Seçilen filtre parametreleri katalog ekranına güvenle aktarılır.

  /// [ÜST AÇIKLAMA]: Kullanıcıya özel karşılama ve rehberlik kartı bileşeni
  Widget _buildGreetingHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.secondaryContainer.withAlpha(90),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.tune, size: 36, color: colorScheme.secondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hadi sana uygun aracı seçelim!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sayın ${widget.registeredUser.fullName}, kullanım amacını seçerek en iyi fiyatı yakala.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // [ALT AÇIKLAMA]: Kullanıcı ismiyle kişiselleştirilmiş rehberlik sunar.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiralama Kriterleri'),
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
              _buildGreetingHeader(context),
              const SizedBox(height: 16),
              VehicleFilterDropdownCard(
                controller: _filterController,
                onContinue: _navigateToCatalog,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: VehicleFilterView, temiz sorumluluk ayrımı ile filtre parametrelerini
// toplayarak sonraki aşamaya iletir ve 40 satır sınırını aşmaz.
