import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final ExamModel exam;
  final bool canEdit;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const ExamCard({
    super.key,
    required this.exam,
    required this.canEdit,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildTypeBadge(),
                const SizedBox(width: 10),
                Expanded(child: _buildTitle()),
                if (canEdit) _buildActions(),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        exam.examType,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      exam.courseName,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.earthDark, size: 20),
            onPressed: onEdit,
          ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
          onPressed: onDelete,
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 14, color: AppColors.blueGradientStart),
            const SizedBox(width: 6),
            Text(
              '${exam.examDate} • ${exam.timeSlot}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.room, size: 14, color: AppColors.earthDark),
            const SizedBox(width: 6),
            Text(
              'Derslik: ${exam.classroom}',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ],
        ),
        if (exam.note.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Not: ${exam.note}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textDark),
            ),
          ),
      ],
    );
  }
}
