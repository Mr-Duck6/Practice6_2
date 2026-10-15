import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:practice6_2/models/task.dart';
import '../state/board_model.dart';
import '../state/filter_model.dart';
import 'task_card_widget.dart';
import '../screens/edit_task_screen.dart';

class ColumnWidget extends StatelessWidget {
  final String title;
  final TaskStatus status;

  const ColumnWidget({super.key, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: ColumnWidget ($title)');

    return Selector2<BoardModel, FilterModel, List<Task>>(
      selector: (_, boardModel, filterModel) {
        final filter = filterModel.filter;
        return boardModel.tasks.where((task) {
          if (task.status != status) return false;
          if (filter.assignee != null && filter.assignee!.isNotEmpty) {
            if (task.assignee != filter.assignee) return false;
          }
          if (filter.priority != null && task.priority != filter.priority) {
            return false;
          }
          return true;
        }).toList();
      },
      shouldRebuild: (previous, next) => !listEquals(previous, next),
      builder: (context, filteredTasks, child) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$title (${filteredTasks.length})',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCardWidget(
                        task: task,
                        onStatusChanged: (newStatus) {
                          if (newStatus != null) {
                            context
                                .read<BoardModel>()
                                .moveTask(task.id, newStatus);
                          }
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditTaskScreen(taskId: task.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
