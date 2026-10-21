import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/course_model.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final bool canEdit;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const CourseCard({
    super.key,
    required this.course,
    required this.canEdit,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _buildLeadingBadge(),
            const SizedBox(width: 14),
            Expanded(child: _buildCourseInfo()),
            if (canEdit) _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingBadge() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.school, color: AppColors.white, size: 24),
    );
  }

  Widget _buildCourseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${course.day} • ${course.timeSlot}',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.blueGradientStart,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (course.classroom.isNotEmpty || course.instructor.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '${course.classroom} ${course.instructor.isNotEmpty ? '• ${course.instructor}' : ''}',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.earthDark),
            onPressed: onEdit,
          ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: AppColors.error),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
