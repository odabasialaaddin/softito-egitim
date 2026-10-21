import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_nav_drawer.dart';
import '../../../core/widget/role_header_badge.dart';
import '../controller/todo_controller.dart';
import '../models/todo_model.dart';
import '../widget/todo_item_tile.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppNavDrawer(currentRoute: 'todo'),
      appBar: AppBar(
        title: const Text(AppStrings.todoTitle),
        actions: const [ThemeModeSwitchButton()],
      ),
      body: Column(
        children: [
          const RoleHeaderBadge(),
          Expanded(child: _buildTodoList()),
        ],
      ),
      floatingActionButton: Container(
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
          onPressed: _showAddTodoDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add_task, color: AppColors.white),
          label: const Text(
            AppStrings.addTask,
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return ValueListenableBuilder<List<TodoModel>>(
      valueListenable: TodoController.instance.todos,
      builder: (context, todos, _) {
        if (todos.isEmpty) {
          return const Center(
            child: Text(
              'Henüz eklenmiş görev bulunmamaktadır.',
              style: TextStyle(color: AppColors.textDark),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoItemTile(
              todo: todo,
              onToggle: () => TodoController.instance.toggleTodo(todo.id),
              onDelete: () => TodoController.instance.removeTodo(todo.id),
            );
          },
        );
      },
    );
  }

  void _showAddTodoDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String priority = 'Normal';
    final priorities = ['Düşük', 'Normal', 'Yüksek'];

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text(AppStrings.addTask),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: AppStrings.taskTitle),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: AppStrings.taskDescription),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: priority,
                  dropdownColor: AppColors.skyBlueLight,
                  decoration: const InputDecoration(labelText: 'Öncelik'),
                  items: priorities
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => priority = val);
                  },
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
                if (titleController.text.trim().isNotEmpty) {
                  TodoController.instance.addTodo(
                    TodoModel(
                      id: 't_${DateTime.now().millisecondsSinceEpoch}',
                      title: titleController.text.trim(),
                      description: descController.text.trim(),
                      priority: priority,
                      createdAt: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
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
