import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks_feature/tasks_controller.dart';
import 'package:tasky/models/taskModel.dart';
import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/tasks_list_widgets.dart';

class HighPriorityTasksScreen extends StatelessWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (BuildContext _) => TasksController()..init(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text("High Priority Tasks")),
          body: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Consumer<TasksController>(
                builder:
                    (
                      BuildContext context,
                      TasksController value,
                      Widget? child,
                    ) {
                      return TasksListWidgets(
                        taskList: value.highPriorityTasksList,
                        onTap: (bool? value, int? index) async {
                          context.read<TasksController>().doneHighPriorityTask(
                            value,
                            index,
                          );
                        },
                        onDelete: (int? id) {
                          context
                              .read<TasksController>()
                              .deleteTask(id);
                        },
                        onEdit: () {
                          context.read<TasksController>().loadTasks();
                        },
                      );
                    },
              ),
            ),
          ),
        );
      },
    );
  }
}
