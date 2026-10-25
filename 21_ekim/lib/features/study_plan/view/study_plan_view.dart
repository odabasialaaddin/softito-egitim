import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_nav_drawer.dart';
import '../../../core/widget/role_header_badge.dart';
import '../controller/study_plan_controller.dart';
import '../models/study_plan_model.dart';
import '../widget/study_slot_card.dart';

class StudyPlanView extends StatefulWidget {
  const StudyPlanView({super.key});

  @override
  State<StudyPlanView> createState() => _StudyPlanViewState();
}

class _StudyPlanViewState extends State<StudyPlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppNavDrawer(currentRoute: 'study_plan'),
      appBar: AppBar(
        title: const Text(AppStrings.studyPlanTitle),
        actions: const [ThemeModeSwitchButton()],
      ),
      body: Column(
        children: [
          const RoleHeaderBadge(),
          Expanded(child: _buildPlansList()),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppColors.blueGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueGradientStart.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: _showAddPlanDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add, color: AppColors.white),
          label: const Text(
            AppStrings.addStudySlot,
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildPlansList() {
    return ValueListenableBuilder<List<StudyPlanModel>>(
      valueListenable: StudyPlanController.instance.plans,
      builder: (context, plans, _) {
        if (plans.isEmpty) {
          return const Center(
            child: Text(
              'Henüz çalışma planı oluşturmadınız.',
              style: TextStyle(color: AppColors.textDark),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return StudySlotCard(
              plan: plan,
              onToggle: () =>
                  StudyPlanController.instance.toggleCompletion(plan.id),
              onDelete: () =>
                  StudyPlanController.instance.removePlan(plan.id),
            );
          },
        );
      },
    );
  }

  void _showAddPlanDialog() {
    final subjectController = TextEditingController();
    final goalController = TextEditingController();
    String selectedDay = 'Pazartesi';
    String selectedTime = '16:00 - 17:30';

    final days = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];
    final times = [
      '08:00 - 09:30',
      '10:00 - 11:30',
      '14:00 - 15:30',
      '16:00 - 17:30',
      '18:00 - 19:30',
      '20:00 - 21:30',
    ];

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text(AppStrings.addStudySlot),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: AppStrings.subject),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: selectedDay,
                  dropdownColor: AppColors.skyBlueLight,
                  decoration: const InputDecoration(labelText: AppStrings.day),
                  items: days
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedDay = val);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: selectedTime,
                  dropdownColor: AppColors.skyBlueLight,
                  decoration: const InputDecoration(labelText: AppStrings.timeSlot),
                  items: times
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedTime = val);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: goalController,
                  decoration: const InputDecoration(labelText: AppStrings.goal),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                if (subjectController.text.trim().isNotEmpty) {
                  StudyPlanController.instance.addPlan(
                    StudyPlanModel(
                      id: 'sp_${DateTime.now().millisecondsSinceEpoch}',
                      day: selectedDay,
                      timeSlot: selectedTime,
                      subject: subjectController.text.trim(),
                      goal: goalController.text.trim(),
                    ),
                  );
                  Navigator.pop(ctx);
                }
              },
              child: const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
