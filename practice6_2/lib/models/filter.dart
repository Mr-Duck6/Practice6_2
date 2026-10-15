import 'task.dart';

class TaskFilter {
  final String? assignee;
  final TaskPriority? priority;

  const TaskFilter({this.assignee, this.priority});

  TaskFilter copyWith({
    String? assignee,
    bool clearAssignee = false,
    TaskPriority? priority,
    bool clearPriority = false,
  }) {
    return TaskFilter(
      assignee: clearAssignee ? null : (assignee ?? this.assignee),
      priority: clearPriority ? null : (priority ?? this.priority),
    );
  }
}
