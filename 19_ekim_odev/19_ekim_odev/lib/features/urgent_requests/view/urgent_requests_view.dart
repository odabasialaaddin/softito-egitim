import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/urgent_requests_controller.dart';
import '../models/urgent_request_model.dart';
import '../widget/urgent_request_card.dart';
import '../widget/urgent_request_dialog.dart';

/// Acil kan taleplerinin listelendiği ve filtrelendiği görünüm.
class UrgentRequestsView extends StatelessWidget {
  final UrgentRequestsController controller;

  const UrgentRequestsView({super.key, required this.controller});

  static const List<String> bloodFilters = [
    '0 Rh-', '0 Rh+', 'A Rh-', 'A Rh+', 'B Rh-', 'B Rh+', 'AB Rh-', 'AB Rh+',
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UrgentRequest>>(
      valueListenable: controller.requestsNotifier,
      builder: (context, _, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: controller.selectedFilterBloodType,
          builder: (context, selectedFilter, _) {
            final requests = controller.filteredRequests;
            return Scaffold(
              body: _UrgentRequestsBody(
                controller: controller,
                requests: requests,
                selectedFilter: selectedFilter,
                bloodFilters: bloodFilters,
              ),
              floatingActionButton: _CreateRequestFab(
                onPressed: () => _openCreateDialog(context),
              ),
            );
          },
        );
      },
    );
  }

  void _openCreateDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => UrgentRequestBottomSheet(
        onSubmit: controller.addRequest,
      ),
    );
  }
}

class _UrgentRequestsBody extends StatelessWidget {
  final UrgentRequestsController controller;
  final List<UrgentRequest> requests;
  final String? selectedFilter;
  final List<String> bloodFilters;

  const _UrgentRequestsBody({
    required this.controller,
    required this.requests,
    required this.selectedFilter,
    required this.bloodFilters,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _UrgentAlertBanner(),
          const SizedBox(height: 14),
          _FilterChipsRow(
            bloodFilters: bloodFilters,
            selectedFilter: selectedFilter,
            onSelect: controller.filterByBloodType,
          ),
          const SizedBox(height: 14),
          _RequestsList(
            requests: requests,
            onFulfill: controller.fulfillUnit,
          ),
          const SizedBox(height: 80), // FAB boşluğu
        ],
      ),
    );
  }
}

class _UrgentAlertBanner extends StatelessWidget {
  const _UrgentAlertBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.statusCritical.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.statusCritical.withValues(alpha: 0.3),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.campaign_rounded, color: AppColors.statusCritical, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Aşağıdaki hastanelerde acil ameliyatlar için kan bağışı beklenmektedir.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.statusCritical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  final List<String> bloodFilters;
  final String? selectedFilter;
  final ValueChanged<String?> onSelect;

  const _FilterChipsRow({
    required this.bloodFilters,
    required this.selectedFilter,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: const Text('Tümü'),
            selected: selectedFilter == null,
            onSelected: (_) => onSelect(null),
          ),
          const SizedBox(width: 6),
          ...bloodFilters.map((type) {
            final isSelected = type == selectedFilter;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (_) => onSelect(type),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RequestsList extends StatelessWidget {
  final List<UrgentRequest> requests;
  final ValueChanged<String> onFulfill;

  const _RequestsList({required this.requests, required this.onFulfill});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'Seçili filtreye ait acil talep bulunamadı.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }

    return Column(
      children: requests
          .map(
            (req) => UrgentRequestCard(
              request: req,
              onFulfill: () => onFulfill(req.id),
            ),
          )
          .toList(),
    );
  }
}

class _CreateRequestFab extends StatelessWidget {
  final VoidCallback onPressed;

  const _CreateRequestFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.add_alert_rounded),
      label: const Text('Acil Talep Aç'),
    );
  }
}
