import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice6_2/models/task.dart';
import '../state/board_model.dart';
import '../state/filter_model.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<BoardModel>().tasks;
    final filterModel = context.watch<FilterModel>();
    final filter = filterModel.filter;
    final assignees = tasks.map((task) => task.assignee).toSet().toList()
      ..sort();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DropdownButton<String?>(
            value: filter.assignee,
            hint: const Text('Усі виконавці'),
            items: [
              const DropdownMenuItem<String?>(
                value: null,
                child: Text('Усі виконавці'),
              ),
              for (final assignee in assignees)
                DropdownMenuItem<String?>(
                  value: assignee,
                  child: Text(assignee),
                ),
            ],
            onChanged: filterModel.setAssignee,
          ),
          DropdownButton<TaskPriority?>(
            value: filter.priority,
            hint: const Text('Усі пріоритети'),
            items: const [
              DropdownMenuItem<TaskPriority?>(
                value: null,
                child: Text('Усі пріоритети'),
              ),
              DropdownMenuItem<TaskPriority?>(
                value: TaskPriority.low,
                child: Text('Низький'),
              ),
              DropdownMenuItem<TaskPriority?>(
                value: TaskPriority.medium,
                child: Text('Середній'),
              ),
              DropdownMenuItem<TaskPriority?>(
                value: TaskPriority.high,
                child: Text('Високий'),
              ),
            ],
            onChanged: filterModel.setPriority,
          ),
          TextButton(
            onPressed: filterModel.clearFilters,
            child: const Text('Очистити фільтри'),
          ),
        ],
      ),
    );
  }
}
