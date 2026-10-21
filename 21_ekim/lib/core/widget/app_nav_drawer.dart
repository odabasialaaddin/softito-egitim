import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/view/login_view.dart';
import '../../features/schedule/view/schedule_view.dart';
import '../../features/study_plan/view/study_plan_view.dart';
import '../../features/todo/view/todo_view.dart';
import '../../features/exam_calendar/view/exam_calendar_view.dart';
import '../../features/communication/view/communication_view.dart';

class AppNavDrawer extends StatelessWidget {
  final String currentRoute;

  const AppNavDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.currentUser.value;
    final isTeacher = user?.isTeacher ?? false;

    return Drawer(
      backgroundColor: AppColors.creamBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerUserHeader(
            name: user?.name ?? 'Kullanıcı',
            email: user?.email ?? 'kullanici@okul.k12.tr',
            roleText: isTeacher ? AppStrings.roleTeacher : AppStrings.roleStudent,
          ),
          _DrawerItem(
            icon: Icons.calendar_month,
            title: AppStrings.scheduleTitle,
            isSelected: currentRoute == 'schedule',
            onTap: () => _navigate(context, const ScheduleView()),
          ),
          _DrawerItem(
            icon: Icons.menu_book,
            title: AppStrings.studyPlanTitle,
            isSelected: currentRoute == 'study_plan',
            onTap: () => _navigate(context, const StudyPlanView()),
          ),
          _DrawerItem(
            icon: Icons.check_circle_outline,
            title: AppStrings.todoTitle,
            isSelected: currentRoute == 'todo',
            onTap: () => _navigate(context, const TodoView()),
          ),
          _DrawerItem(
            icon: Icons.assignment_outlined,
            title: AppStrings.examCalendarTitle,
            isSelected: currentRoute == 'exam_calendar',
            onTap: () => _navigate(context, const ExamCalendarView()),
          ),
          _DrawerItem(
            icon: Icons.chat_bubble_outline,
            title: AppStrings.communicationTitle,
            isSelected: currentRoute == 'communication',
            onTap: () => _navigate(context, const CommunicationView()),
          ),
          const Divider(color: AppColors.borderLight),
          _DrawerItem(
            icon: Icons.logout,
            title: AppStrings.logout,
            isSelected: false,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
  }

  void _logout(BuildContext context) {
    AuthController.instance.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginView()),
      (route) => false,
    );
  }
}

class _DrawerUserHeader extends StatelessWidget {
  final String name;
  final String email;
  final String roleText;

  const _DrawerUserHeader({
    required this.name,
    required this.email,
    required this.roleText,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(gradient: AppColors.blueGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white.withValues(alpha: 0.25),
            radius: 26,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'U',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                email,
                style: const TextStyle(color: AppColors.skyBlueLight, fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  roleText,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.blueGradientStart : AppColors.textDark,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.blueGradientStart : AppColors.textDark,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.skyBlueMedium.withValues(alpha: 0.5),
      onTap: onTap,
    );
  }
}
