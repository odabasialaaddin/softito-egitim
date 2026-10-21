import 'package:flutter_test/flutter_test.dart';
import 'package:ders_programi_duzenleyici/features/todo/controller/todo_controller.dart';
import 'package:ders_programi_duzenleyici/features/todo/models/todo_model.dart';

void main() {
  group('TodoController Tests', () {
    final controller = TodoController.instance;

    test('addTodo, toggleTodo and removeTodo work reactively', () {
      const newTodo = TodoModel(
        id: 'test_todo',
        title: 'Ödevi Bitir',
        isCompleted: false,
      );

      controller.addTodo(newTodo);
      expect(controller.todos.value.any((t) => t.id == 'test_todo'), isTrue);

      controller.toggleTodo('test_todo');
      final toggled = controller.todos.value.firstWhere((t) => t.id == 'test_todo');
      expect(toggled.isCompleted, isTrue);

      controller.removeTodo('test_todo');
      expect(controller.todos.value.any((t) => t.id == 'test_todo'), isFalse);
    });
  });
}
