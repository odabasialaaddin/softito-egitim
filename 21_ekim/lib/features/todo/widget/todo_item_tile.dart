import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/todo_model.dart';

class TodoItemTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemTile({
    super.key,
    required this.todo,
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
              value: todo.isCompleted,
              activeColor: AppColors.blueGradientStart,
              onChanged: (_) => onToggle(),
            ),
            Expanded(child: _buildTodoContent()),
            _buildPriorityBadge(),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: todo.isCompleted ? AppColors.textMuted : AppColors.textDark,
            decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        if (todo.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              todo.description,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPriorityBadge() {
    Color badgeColor = AppColors.grassGreenDark;
    if (todo.priority == 'Yüksek') badgeColor = AppColors.error;
    if (todo.priority == 'Normal') badgeColor = AppColors.warning;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        todo.priority,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
}
