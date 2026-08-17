import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/taskModel.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/tasks_list_widgets.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTasksList = [];

  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final taskEnCode = SharedPreferencesManager().getString(StorgeKey.tasks);

    if (taskEnCode != null) {
      final taskAfterDecode = jsonDecode(taskEnCode) as List<dynamic>;

      final taskFinal = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      setState(() {
        highPriorityTasksList = taskFinal;
        highPriorityTasksList = highPriorityTasksList
            .where((element) => element.isHighPriority)
            .toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];

    if (id == null) return;

    final finalTask = SharedPreferencesManager().getString(StorgeKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((element) => element.id == id);

      setState(() {
        highPriorityTasksList.removeWhere((taskList) => taskList.id == id);
      });

      final upDatedTask = tasks.map((element) => element.toJson()).toList();
      SharedPreferencesManager().setString(StorgeKey.tasks, jsonEncode(upDatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: TasksListWidgets(
            taskList: highPriorityTasksList,
            onTap: (bool? value, int? index) async {
              setState(() {
                highPriorityTasksList[index!].isDone = value ?? false;
              });
              final allData = SharedPreferencesManager().getString(StorgeKey.tasks);

              if (allData != null) {
                List<dynamic> list = (jsonDecode(allData) as List);

                List<TaskModel> allDataList = list
                    .map((e) => TaskModel.fromJson(e))
                    .toList();

                final int newIndex = allDataList.indexWhere(
                  (e) => e.id == highPriorityTasksList[index!].id,
                );
                allDataList[newIndex] = highPriorityTasksList[index!];

                await SharedPreferencesManager().setString(
                  StorgeKey.tasks,
                  jsonEncode(allDataList),
                );
                _loadTask();
              }
            },
            onDelete: (int? id) {
              _deleteTask(id);
            }, onEdit: () {
              _loadTask();
          },
          ),
        ),
      ),
    );
  }
}
