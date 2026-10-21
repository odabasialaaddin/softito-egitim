import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class ConflictAlertDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onDismiss;

  const ConflictAlertDialog({
    super.key,
    required this.errorMessage,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              AppStrings.conflictWarningTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.conflictWarningDesc,
            style: TextStyle(fontSize: 14, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.earthLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.5)),
            ),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: onDismiss,
          child: const Text(AppStrings.ok),
        ),
      ],
    );
  }
}
