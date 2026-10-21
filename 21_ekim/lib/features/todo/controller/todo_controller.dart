import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';

class TodoController {
  TodoController._internal();
  static final TodoController instance = TodoController._internal();

  final ValueNotifier<List<TodoModel>> todos =
      ValueNotifier<List<TodoModel>>(_initialTodos);

  void addTodo(TodoModel todo) {
    todos.value = [todo, ...todos.value];
  }

  void toggleTodo(String id) {
    todos.value = [
      for (final t in todos.value)
        if (t.id == id) t.copyWith(isCompleted: !t.isCompleted) else t,
    ];
  }

  void removeTodo(String id) {
    todos.value = todos.value.where((t) => t.id != id).toList();
  }

  void dispose() {
    todos.dispose();
  }

  static final List<TodoModel> _initialTodos = [
    const TodoModel(
      id: 't1',
      title: 'Matematik 3. Hafta Ödevini Çöz',
      description: 'Diferansiyel denklemler sayfa 45-48 arası sorular',
      isCompleted: false,
      priority: 'Yüksek',
      createdAt: '21 Ekim 2026',
    ),
    const TodoModel(
      id: 't2',
      title: 'Fizik Laboratuvar Raporunu Hazırla',
      description: 'Sürtünme katsayısı deney verilerini excel tablosuna dök',
      isCompleted: true,
      priority: 'Normal',
      createdAt: '20 Ekim 2026',
    ),
    const TodoModel(
      id: 't3',
      title: 'Vize Sınav Takvimini Kontrol Et',
      description: 'Sınav salonları ve çakışma durumlarını incele',
      isCompleted: false,
      priority: 'Düşük',
      createdAt: '19 Ekim 2026',
    ),
  ];
}
