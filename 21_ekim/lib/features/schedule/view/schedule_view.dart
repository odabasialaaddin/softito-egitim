import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_nav_drawer.dart';
import '../../../core/widget/role_header_badge.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/schedule_controller.dart';
import '../models/course_model.dart';
import '../widget/course_card.dart';
import '../widget/conflict_alert_dialog.dart';
import '../widget/note_section_widget.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.currentUser.value;
    final isTeacher = user?.isTeacher ?? false;

    return Scaffold(
      drawer: const AppNavDrawer(currentRoute: 'schedule'),
      appBar: AppBar(
        title: const Text(AppStrings.scheduleTitle),
        actions: const [ThemeModeSwitchButton()],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          indicatorWeight: 3,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.skyBlueLight.withValues(alpha: 0.7),
          tabs: const [
            Tab(icon: Icon(Icons.schedule), text: 'Dersler'),
            Tab(icon: Icon(Icons.note_alt_outlined), text: 'Not & Duyuru'),
          ],
        ),
      ),
      body: Column(
        children: [
          const RoleHeaderBadge(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCoursesList(isTeacher),
                NoteSectionWidget(isTeacher: isTeacher),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isTeacher ? _buildAddCourseFab() : null,
    );
  }

  Widget _buildCoursesList(bool isTeacher) {
    return ValueListenableBuilder<List<CourseModel>>(
      valueListenable: ScheduleController.instance.courses,
      builder: (context, courseList, _) {
        if (courseList.isEmpty) {
          return const Center(
            child: Text(
              'Henüz eklenmiş ders bulunmamaktadır.',
              style: TextStyle(color: AppColors.textDark),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: courseList.length,
          itemBuilder: (context, index) {
            final course = courseList[index];
            return CourseCard(
              course: course,
              canEdit: isTeacher,
              onDelete: () =>
                  ScheduleController.instance.removeCourse(course.id),
            );
          },
        );
      },
    );
  }

  Widget _buildAddCourseFab() {
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
        onPressed: _showAddCourseDialog,
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text(
          AppStrings.addCourse,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAddCourseDialog() {
    final titleController = TextEditingController();
    final instructorController = TextEditingController();
    final classroomController = TextEditingController();
    String selectedDay = 'Pazartesi';
    String selectedTime = '09:00 - 10:30';

    final days = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'];
    final timeSlots = [
      '09:00 - 10:30',
      '11:00 - 12:30',
      '13:30 - 15:00',
      '15:30 - 17:00',
    ];

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text(AppStrings.addCourse),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: AppStrings.courseName),
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
                  items: timeSlots
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedTime = val);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: instructorController,
                  decoration: const InputDecoration(labelText: AppStrings.instructor),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: classroomController,
                  decoration: const InputDecoration(labelText: AppStrings.classroom),
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
                if (titleController.text.trim().isEmpty) return;

                final newCourse = CourseModel(
                  id: 'c_${DateTime.now().millisecondsSinceEpoch}',
                  title: titleController.text.trim(),
                  day: selectedDay,
                  timeSlot: selectedTime,
                  instructor: instructorController.text.trim(),
                  classroom: classroomController.text.trim(),
                );

                final success =
                    ScheduleController.instance.addCourse(newCourse);
                Navigator.pop(ctx);

                if (!success) {
                  _showConflictDialog();
                }
              },
              child: const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showConflictDialog() {
    final error = ScheduleController.instance.conflictError.value ??
        AppStrings.conflictWarningDesc;
    showDialog<void>(
      context: context,
      builder: (ctx) => ConflictAlertDialog(
        errorMessage: error,
        onDismiss: () {
          ScheduleController.instance.clearConflict();
          Navigator.pop(ctx);
        },
      ),
    );
  }
}
