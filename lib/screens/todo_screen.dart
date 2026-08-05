import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/services/sharedpreferences_manager.dart';
import '../core/widgets/tasks_list_widgets.dart';
import '../models/taskModel.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> todoList = [];

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
        todoList = taskFinal;
        todoList = todoList
            .where((element) => element.isDone == false)
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
        todoList.removeWhere((taskList) => taskList.id == id);
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
          child: Text("To Do Tasks" ,
            style: TextTheme.of(context).titleMedium
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TasksListWidgets(
                taskList: todoList,
                onTap: (bool? value, int? index) async {

                  setState(() {
                    todoList[index!].isDone = value ?? false;
                  });

                  final allData = SharedPreferencesManager().getString("tasks");

                  if (allData != null) {

                    List<dynamic> list = (jsonDecode(allData) as List);

                    List<TaskModel> allDataList = list.map((e) => TaskModel.fromJson(e)).toList();

                    final int newIndex = allDataList.indexWhere(
                          (e) => e.id == todoList[index!].id,
                    );
                    allDataList[newIndex] = todoList[index!];

                    await SharedPreferencesManager().setString("tasks", jsonEncode(allDataList));
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
