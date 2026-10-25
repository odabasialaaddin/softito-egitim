import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../features/auth/controller/auth_controller.dart';

class RoleHeaderBadge extends StatelessWidget {
  const RoleHeaderBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthController.instance.currentUser,
      builder: (context, user, _) {
        final isTeacher = user?.isTeacher ?? false;
        final roleLabel = isTeacher ? 'Öğretmen Girişi' : 'Öğrenci Girişi';
        final icon = isTeacher ? Icons.school : Icons.person;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            gradient: isTeacher
                ? AppColors.blueGradient
                : const LinearGradient(
                    colors: [Color(0xFF263238), Color(0xFF37474F)],
                  ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.white, size: 15),
              const SizedBox(width: 6),
              Text(
                roleLabel,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
