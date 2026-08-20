import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks_feature/tasks_controller.dart';
import '../../core/widgets/tasks_list_widgets.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<TasksController>(
      create: (BuildContext context) => TasksController()..init(),
      builder: (context , _){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Completed Tasks",
                style: TextTheme.of(context).titleMedium,
              ),
            ),

            Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),

                    child: Consumer<TasksController>(

                      builder: (BuildContext context, TasksController value, Widget? child) {
                        return TasksListWidgets(
                          taskList: value.completedTasks,

                          onTap: (bool? value, int? index) async {
                            context.read<TasksController>().doneCompletedTask(value, index);

                          },
                          onDelete: (int? id) {
                            context.read<TasksController>().deleteTask(id);

                          },
                          onEdit: () {
                            context.read<TasksController>().loadTasks();

                          },
                        );
                      },
                    ),
                  ),
                )

          ],
        );
      }
    );
  }
}
