enum TaskStatus { todo, inProgress, done }
enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String assignee;
  final TaskPriority priority;
  final TaskStatus status;

  const Task({
    required this.id,
    required this.title,
    required this.assignee,
    required this.priority,
    required this.status,
  });

  Task copyWith({
    String? id,
    String? title,
    String? assignee,
    TaskPriority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      assignee: assignee ?? this.assignee,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}