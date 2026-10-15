import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:practice6_2/models/task.dart';
import '../state/board_model.dart';
import '../widgets/column_widget.dart';
import '../widgets/filter_widget.dart';
import 'edit_task_screen.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: BoardScreen');
    final boardModel = context.watch<BoardModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Дошка'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (boardModel.status == BoardStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (boardModel.status == BoardStateStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Помилка: ${boardModel.errorMessage}',
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => boardModel.loadTasks(),
                    child: const Text('Повторити'),
                  ),
                ],
              ),
            );
          }
          return const Column(
            children: [
              FilterWidget(),
              Expanded(
                child: Row(
                  children: [
                    ColumnWidget(
                        title: 'До виконання', status: TaskStatus.todo),
                    ColumnWidget(
                        title: 'В роботі', status: TaskStatus.inProgress),
                    ColumnWidget(title: 'Готово', status: TaskStatus.done),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
