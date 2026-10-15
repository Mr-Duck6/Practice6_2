import 'package:flutter/material.dart';
import 'package:practice6_2/models/task.dart';

class TaskCardWidget extends StatelessWidget {
  final Task task;
  final ValueChanged<TaskStatus?> onStatusChanged;
  final VoidCallback onTap;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onTap,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.red.shade100;
      case TaskPriority.medium:
        return Colors.orange.shade100;
      case TaskPriority.low:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: TaskCardWidget ${task.id}');
    return Card(
      color: _getPriorityColor(),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(task.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Виконавець: ${task.assignee} | Пріоритет: ${task.priority.name}'),
        trailing: DropdownButton<TaskStatus>(
          value: task.status,
          items: const [
            DropdownMenuItem(value: TaskStatus.todo, child: Text('До')),
            DropdownMenuItem(
                value: TaskStatus.inProgress, child: Text('В роботі')),
            DropdownMenuItem(value: TaskStatus.done, child: Text('Готово')),
          ],
          onChanged: onStatusChanged,
        ),
        onTap: onTap,
      ),
    );
  }
}
