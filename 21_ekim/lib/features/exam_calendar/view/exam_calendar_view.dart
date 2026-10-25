import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_nav_drawer.dart';
import '../../../core/widget/role_header_badge.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/exam_calendar_controller.dart';
import '../models/exam_model.dart';
import '../widget/exam_card.dart';

class ExamCalendarView extends StatefulWidget {
  const ExamCalendarView({super.key});

  @override
  State<ExamCalendarView> createState() => _ExamCalendarViewState();
}

class _ExamCalendarViewState extends State<ExamCalendarView> {
  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.currentUser.value;
    final isTeacher = user?.isTeacher ?? false;

    return Scaffold(
      drawer: const AppNavDrawer(currentRoute: 'exam_calendar'),
      appBar: AppBar(
        title: const Text(AppStrings.examCalendarTitle),
        actions: const [ThemeModeSwitchButton()],
      ),
      body: Column(
        children: [
          const RoleHeaderBadge(),
          Expanded(child: _buildExamsList(isTeacher)),
        ],
      ),
      floatingActionButton: isTeacher ? _buildAddExamFab() : null,
    );
  }

  Widget _buildExamsList(bool isTeacher) {
    return ValueListenableBuilder<List<ExamModel>>(
      valueListenable: ExamCalendarController.instance.exams,
      builder: (context, exams, _) {
        if (exams.isEmpty) {
          return const Center(
            child: Text(
              'Henüz sınav programı bulunmamaktadır.',
              style: TextStyle(color: AppColors.textDark),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: exams.length,
          itemBuilder: (context, index) {
            final exam = exams[index];
            return ExamCard(
              exam: exam,
              canEdit: isTeacher,
              onDelete: () =>
                  ExamCalendarController.instance.removeExam(exam.id),
            );
          },
        );
      },
    );
  }

  Widget _buildAddExamFab() {
    return Container(
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
        onPressed: _showAddExamDialog,
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text(
          AppStrings.addExam,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAddExamDialog() {
    final courseController = TextEditingController();
    final dateController = TextEditingController(text: '20 Kasım 2026');
    final timeController = TextEditingController(text: '10:00 - 11:30');
    final roomController = TextEditingController();
    final noteController = TextEditingController();
    String examType = 'Vize';
    final examTypes = ['Vize', 'Final', 'Bütünleme', 'Quiz'];

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text(AppStrings.addExam),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: AppStrings.courseName),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: examType,
                  dropdownColor: AppColors.skyBlueLight,
                  decoration: const InputDecoration(labelText: AppStrings.examType),
                  items: examTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => examType = val);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: AppStrings.examDate),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: AppStrings.timeSlot),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: roomController,
                  decoration: const InputDecoration(labelText: AppStrings.classroom),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: 'Açıklama / Not'),
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
                if (courseController.text.trim().isNotEmpty) {
                  ExamCalendarController.instance.addExam(
                    ExamModel(
                      id: 'e_${DateTime.now().millisecondsSinceEpoch}',
                      courseName: courseController.text.trim(),
                      examDate: dateController.text.trim(),
                      timeSlot: timeController.text.trim(),
                      classroom: roomController.text.trim(),
                      examType: examType,
                      note: noteController.text.trim(),
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
