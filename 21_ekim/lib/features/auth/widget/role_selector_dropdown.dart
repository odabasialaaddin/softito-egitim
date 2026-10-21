import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../models/user_model.dart';

class RoleSelectorDropdown extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole?> onChanged;

  const RoleSelectorDropdown({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.skyBlueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserRole>(
          value: selectedRole,
          isExpanded: true,
          dropdownColor: AppColors.skyBlueLight,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.earthDark),
          items: const [
            DropdownMenuItem(
              value: UserRole.teacher,
              child: _RoleItem(
                icon: Icons.school_outlined,
                title: AppStrings.roleTeacher,
              ),
            ),
            DropdownMenuItem(
              value: UserRole.student,
              child: _RoleItem(
                icon: Icons.person_outline,
                title: AppStrings.roleStudent,
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _RoleItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _RoleItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grassGreenDark, size: 20),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
