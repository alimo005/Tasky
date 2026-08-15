import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/taskModel.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/tasks_list_widgets.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> completedTask = [];

  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final taskEnCode = SharedPreferencesManager().getString("tasks");

    if (taskEnCode != null) {
      final taskAfterDecode = jsonDecode(taskEnCode) as List<dynamic>;

      final taskFinal = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      setState(() {
        completedTask = taskFinal;
        completedTask = completedTask
            .where((element) => element.isDone == true)
            .toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = SharedPreferencesManager().getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((element) => element.id == id);

      setState(() {
        completedTask.removeWhere((taskList) => taskList.id == id);
      });

      final upDatedTask = tasks
          .map((element) => element.toJson())
          .toList();
      SharedPreferencesManager().setString("tasks", jsonEncode(upDatedTask));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Completed Tasks",
            style:TextTheme.of(context).titleMedium
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TasksListWidgets(
              taskList: completedTask,

              onTap: (bool? value, int? index) async {
                setState(() {
                  completedTask[index!].isDone = value ?? false;
                });

                final allData = SharedPreferencesManager().getString("tasks");

                if (allData != null) {
                  List<dynamic> list = (jsonDecode(allData) as List);

                  List<TaskModel> allDataList = list
                      .map((e) => TaskModel.fromJson(e))
                      .toList();

                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == completedTask[index!].id,
                  );
                  allDataList[newIndex] = completedTask[index!];

                  await SharedPreferencesManager().setString(
                    "tasks",
                    jsonEncode(allDataList),
                  );
                  _loadTask();
                }
              }, onDelete: (int? id) {
              _deleteTask(id);
            }, onEdit: () {
                _loadTask();
            },
            ),
          ),
        ),
      ],
    );
  }
}
