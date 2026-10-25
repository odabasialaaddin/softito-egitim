import 'package:flutter/material.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../vehicle_filter/view/vehicle_filter_view.dart';
import '../controller/auth_register_controller.dart';
import '../widget/auth_register_form_widget.dart';

/// [ÜST AÇIKLAMA]: AuthRegisterView, Kirala uygulamasının ilk karşılama ve kayıt ekranıdır.
/// Kullanıcı bilgilerini toplayıp sıkı validasyondan geçirir ve başarılı kayıt durumunda
/// bilgilendirme diyaloğu göstererek araç filtreleme ekranına yönlendirir.
/// 40 satır build sınırına titizlikle uyulmuştur.
class AuthRegisterView extends StatefulWidget {
  final ThemeController themeController;

  const AuthRegisterView({
    super.key,
    required this.themeController,
  });

  @override
  State<AuthRegisterView> createState() => _AuthRegisterViewState();
}

class _AuthRegisterViewState extends State<AuthRegisterView> {
  late final AuthRegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AuthRegisterController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// [ÜST AÇIKLAMA]: Kayıt başarılı olduğunda kullanıcıya gösterilen onay diyaloğu.
  /// İşlem sonucunu açık ve pedagojik biçimde bildirir.
  Future<void> _handleRegistrationSuccess() async {
    final isValid = _controller.submitForm();
    if (!isValid || !mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        icon: const Icon(Icons.check_circle_outline, size: 48, color: Colors.green),
        title: const Text('Kayıt Başarılı'),
        content: const Text(
          'Kaydoldunuz! Araç seçim ekranına yönlendiriliyorsunuz...',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VehicleFilterView(
                    themeController: widget.themeController,
                    registeredUser: _controller.registeredUserNotifier.value!,
                  ),
                ),
              );
            },
            child: const Text('Araç Seçimine Geç'),
          ),
        ],
      ),
    );
  }
  // [ALT AÇIKLAMA]: Diyalog onaylandığında kullanıcı 2. sayfa olan VehicleFilterView'a aktarılır.

  /// [ÜST AÇIKLAMA]: Karşılama başlığını ve çağrı metnini içeren karşılama kartı
  Widget _buildWelcomeHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer.withAlpha(80),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.directions_car_filled, size: 40, color: colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kayıt ol ve ihtiyacın olan araca ulaş',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hızlı, güvenilir ve dakikalar içinde kiralama deneyimi.',
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
  // [ALT AÇIKLAMA]: Karşılama kartı, Material 3 tema renk belirteçleriyle şık bir ilk izlenim sunar.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kirala • Akıllı Araç'),
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
              _buildWelcomeHeader(context),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AuthRegisterFormWidget(
                    controller: _controller,
                    onSubmitted: _handleRegistrationSuccess,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// [ALT AÇIKLAMA]: AuthRegisterView, 40 satırın altındaki build metodu ve temiz
// parçalanmış yardımcı bileşenleri ile kod okunabilirliğini en üst düzeyde tutar.
