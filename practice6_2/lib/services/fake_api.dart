import 'dart:math';
import 'package:practice6_2/models/task.dart';

class FakeApi {
  final _random = Random();

  final List<Task> demoTasks = const [
    Task(id: '1', title: 'Налаштувати проєкт', assignee: 'Олег', priority: TaskPriority.high, status: TaskStatus.todo),
    Task(id: '2', title: 'Створити архітектуру', assignee: 'Ірина', priority: TaskPriority.medium, status: TaskStatus.inProgress),
    Task(id: '3', title: 'Написати тести', assignee: 'Олег', priority: TaskPriority.low, status: TaskStatus.done),
  ];

  Future<List<Task>> fetchTasks() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (_random.nextInt(5) == 0) {
      throw Exception('Сервер недоступний');
    }
    return demoTasks;
  }
}