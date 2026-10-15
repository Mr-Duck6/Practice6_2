import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice6_2/models/task.dart';
import 'package:practice6_2/state/board_model.dart';

class EditTaskScreen extends StatefulWidget {
  final String? taskId;

  const EditTaskScreen({super.key, this.taskId});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _assigneeController;
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) {
      final task = context
          .read<BoardModel>()
          .tasks
          .firstWhere((t) => t.id == widget.taskId);
      _titleController = TextEditingController(text: task.title);
      _assigneeController = TextEditingController(text: task.assignee);
      _priority = task.priority;
    } else {
      _titleController = TextEditingController();
      _assigneeController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _assigneeController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final assignee = _assigneeController.text.trim();
    if (title.isEmpty) return;

    final boardModel = context.read<BoardModel>();
    if (widget.taskId == null) {
      boardModel.addTask(
          title, assignee.isEmpty ? 'Не вказано' : assignee, _priority);
    } else {
      final oldTask = boardModel.tasks.firstWhere((t) => t.id == widget.taskId);
      boardModel.updateTask(oldTask.copyWith(
          title: title, assignee: assignee, priority: _priority));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: EditTaskScreen');
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.taskId == null ? 'Нова картка' : 'Редагувати картку'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Назва')),
            TextField(
                controller: _assigneeController,
                decoration: const InputDecoration(labelText: 'Виконавець')),
            DropdownButton<TaskPriority>(
              value: _priority,
              items: const [
                DropdownMenuItem(value: TaskPriority.low, child: Text('Low')),
                DropdownMenuItem(
                    value: TaskPriority.medium, child: Text('Medium')),
                DropdownMenuItem(value: TaskPriority.high, child: Text('High')),
              ],
              onChanged: (val) => setState(() => _priority = val ?? _priority),
            ),
          ],
        ),
      ),
    );
  }
}
