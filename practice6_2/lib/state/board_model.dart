import 'package:flutter/foundation.dart';
import 'package:practice6_2/models/task.dart';
import '../services/fake_api.dart';

enum BoardStateStatus { loading, success, error }

class BoardModel extends ChangeNotifier {
  final FakeApi _api = FakeApi();

  BoardStateStatus _status = BoardStateStatus.loading;
  List<Task> _tasks = [];
  String _errorMessage = '';

  BoardStateStatus get status => _status;
  List<Task> get tasks => _tasks;
  String get errorMessage => _errorMessage;

  BoardModel() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _status = BoardStateStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _tasks = List.from(await _api.fetchTasks());
      _status = BoardStateStatus.success;
    } catch (e) {
      _status = BoardStateStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    notifyListeners();
  }

  void addTask(String title, String assignee, TaskPriority priority) {
    final newTask = Task(
      id: DateTime.now().toIso8601String(),
      title: title,
      assignee: assignee,
      priority: priority,
      status: TaskStatus.todo,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTask(Task updated) {
    final index = _tasks.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      _tasks[index] = updated;
      notifyListeners();
    }
  }

  void moveTask(String id, TaskStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }
}
