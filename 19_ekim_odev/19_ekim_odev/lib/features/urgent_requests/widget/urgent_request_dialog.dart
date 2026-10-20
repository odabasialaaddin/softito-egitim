import 'package:flutter/material.dart';
import '../models/urgent_request_model.dart';

/// Yeni bir acil kan talebi açmak için kullanılan alt form penceresi.
class UrgentRequestBottomSheet extends StatelessWidget {
  final ValueChanged<UrgentRequest> onSubmit;

  UrgentRequestBottomSheet({super.key, required this.onSubmit});

  final TextEditingController patientCtrl = TextEditingController();
  final TextEditingController hospitalCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final ValueNotifier<String> selectedBloodType = ValueNotifier<String>('A Rh+');
  final ValueNotifier<int> requiredUnits = ValueNotifier<int>(2);

  static const List<String> bloodTypes = [
    'A Rh+', 'A Rh-', 'B Rh+', 'B Rh-',
    'AB Rh+', 'AB Rh-', '0 Rh+', '0 Rh-',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SheetTitle(),
          const SizedBox(height: 16),
          _TextFieldItem(
            controller: patientCtrl,
            label: 'Hasta Adı Soyadı',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 10),
          _TextFieldItem(
            controller: hospitalCtrl,
            label: 'Hastane Adı',
            icon: Icons.local_hospital_outlined,
          ),
          const SizedBox(height: 10),
          _TextFieldItem(
            controller: cityCtrl,
            label: 'Şehir / İlçe',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 14),
          _BloodTypeSelector(
            bloodTypes: bloodTypes,
            selectedTypeNotifier: selectedBloodType,
          ),
          const SizedBox(height: 16),
          _SubmitButton(
            onPressed: () => _handleSubmit(context),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    final patient = patientCtrl.text.trim();
    final hospital = hospitalCtrl.text.trim();
    final city = cityCtrl.text.trim();

    if (patient.isEmpty || hospital.isEmpty) return;

    final newRequest = UrgentRequest(
      id: 'urg-${DateTime.now().millisecondsSinceEpoch}',
      patientName: patient,
      hospitalName: hospital,
      city: city.isEmpty ? 'Türkiye' : city,
      bloodType: selectedBloodType.value,
      requiredUnits: requiredUnits.value,
      fulfilledUnits: 0,
      isUrgent: true,
      createdAt: 'Az önce',
    );

    onSubmit(newRequest);
    Navigator.of(context).pop();
  }
}

class _SheetTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Yeni Acil Kan Talebi',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const _TextFieldItem({
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        isDense: true,
      ),
    );
  }
}

class _BloodTypeSelector extends StatelessWidget {
  final List<String> bloodTypes;
  final ValueNotifier<String> selectedTypeNotifier;

  const _BloodTypeSelector({
    required this.bloodTypes,
    required this.selectedTypeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedTypeNotifier,
      builder: (context, current, _) {
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: bloodTypes.map((type) {
            final isSelected = type == current;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (_) => selectedTypeNotifier.value = type,
            );
          }).toList(),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.campaign_rounded),
        label: const Text('Acil Kan Çağrısı Yayınla'),
      ),
    );
  }
}
