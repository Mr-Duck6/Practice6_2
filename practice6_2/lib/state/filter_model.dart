import 'package:flutter/foundation.dart';
import 'package:practice6_2/models/task.dart';
import 'package:practice6_2/models/filter.dart';

class FilterModel extends ChangeNotifier {
  TaskFilter _filter = const TaskFilter();

  TaskFilter get filter => _filter;

  void setAssignee(String? assignee) {
    _filter = _filter.copyWith(assignee: assignee, clearAssignee: assignee == null);
    notifyListeners();
  }

  void setPriority(TaskPriority? priority) {
    _filter = _filter.copyWith(priority: priority, clearPriority: priority == null);
    notifyListeners();
  }

  void clearFilters() {
    _filter = const TaskFilter();
    notifyListeners();
  }
}