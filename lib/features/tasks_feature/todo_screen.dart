import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks_feature/tasks_controller.dart';
import '../../core/widgets/tasks_list_widgets.dart';
import '../../models/taskModel.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "To Do Tasks",
                style: TextTheme.of(context).titleMedium,
              ),
            ),
            Consumer<TasksController>(

              builder: (BuildContext context, TasksController value, Widget? child) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TasksListWidgets(
                      taskList: value.toDoTasks,
                      onTap: (bool? value, int? index) async {
                        context.read<TasksController>().doneTask(value, index);
                      },
                      onDelete: (int? id) {
                        context.read<TasksController>().deleteTask(id);
                      },
                      onEdit: () {
                        context.read<TasksController>().loadTasks();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
