import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/study_plan_model.dart';

class StudySlotCard extends StatelessWidget {
  final StudyPlanModel plan;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const StudySlotCard({
    super.key,
    required this.plan,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Checkbox(
              value: plan.isCompleted,
              activeColor: AppColors.blueGradientStart,
              onChanged: (_) => onToggle(),
            ),
            Expanded(child: _buildPlanDetails()),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plan.subject,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: plan.isCompleted ? AppColors.textMuted : AppColors.textDark,
            decoration:
                plan.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${plan.day} • ${plan.timeSlot}',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.blueGradientStart,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (plan.goal.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'Hedef: ${plan.goal}',
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ),
      ],
    );
  }
}
