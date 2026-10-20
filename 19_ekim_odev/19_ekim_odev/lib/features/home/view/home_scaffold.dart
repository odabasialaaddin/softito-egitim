import 'package:flutter/material.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../blood_inventory_chart/controller/blood_inventory_controller.dart';
import '../../blood_inventory_chart/view/blood_inventory_view.dart';
import '../../donation_reminders/controller/donation_reminders_controller.dart';
import '../../donation_reminders/view/donation_reminders_view.dart';
import '../../donation_tracker/controller/donation_tracker_controller.dart';
import '../../donation_tracker/view/donation_tracker_view.dart';
import '../../urgent_requests/controller/urgent_requests_controller.dart';
import '../../urgent_requests/view/urgent_requests_view.dart';

/// 4 ana özelliği birleştiren ve modern Material 3 alt gezinme çubuğunu barındıran iskelet.
class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  // Modül kontrolcüleri
  late final BloodInventoryController _inventoryController;
  late final DonationTrackerController _trackerController;
  late final UrgentRequestsController _urgentController;
  late final DonationRemindersController _remindersController;

  @override
  void initState() {
    super.initState();
    _inventoryController = BloodInventoryController();
    _trackerController = DonationTrackerController();
    _urgentController = UrgentRequestsController();
    _remindersController = DonationRemindersController();
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    _inventoryController.dispose();
    _trackerController.dispose();
    _urgentController.dispose();
    _remindersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, activeIndex, _) {
        return Scaffold(
          appBar: _HomeAppBar(activeIndex: activeIndex),
          body: _HomeBody(
            activeIndex: activeIndex,
            inventoryController: _inventoryController,
            trackerController: _trackerController,
            urgentController: _urgentController,
            remindersController: _remindersController,
          ),
          bottomNavigationBar: _HomeNavigationBar(
            currentIndex: activeIndex,
            onDestinationSelected: (index) => _currentIndex.value = index,
          ),
        );
      },
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int activeIndex;

  const _HomeAppBar({required this.activeIndex});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(activeIndex);
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
      actions: const [
        ThemeModeSwitchButton(),
        SizedBox(width: 8),
      ],
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'CanVer • Kan Stoğu';
      case 1:
        return 'CanVer • Bağış Takibi';
      case 2:
        return 'CanVer • Acil Talepler';
      case 3:
        return 'CanVer • Hatırlatıcılar';
      default:
        return 'CanVer';
    }
  }
}

class _HomeBody extends StatelessWidget {
  final int activeIndex;
  final BloodInventoryController inventoryController;
  final DonationTrackerController trackerController;
  final UrgentRequestsController urgentController;
  final DonationRemindersController remindersController;

  const _HomeBody({
    required this.activeIndex,
    required this.inventoryController,
    required this.trackerController,
    required this.urgentController,
    required this.remindersController,
  });

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: activeIndex,
      children: [
        BloodInventoryView(controller: inventoryController),
        DonationTrackerView(controller: trackerController),
        UrgentRequestsView(controller: urgentController),
        DonationRemindersView(controller: remindersController),
      ],
    );
  }
}

class _HomeNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const _HomeNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart_rounded),
          label: 'Stok Grafiği',
        ),
        NavigationDestination(
          icon: Icon(Icons.volunteer_activism_outlined),
          selectedIcon: Icon(Icons.volunteer_activism_rounded),
          label: 'Bağış Takibi',
        ),
        NavigationDestination(
          icon: Icon(Icons.campaign_outlined),
          selectedIcon: Icon(Icons.campaign_rounded),
          label: 'Acil Talepler',
        ),
        NavigationDestination(
          icon: Icon(Icons.alarm_outlined),
          selectedIcon: Icon(Icons.alarm_on_rounded),
          label: 'Hatırlatıcı',
        ),
      ],
    );
  }
}
