import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../models/taskModel.dart';

class AddTaskController extends ChangeNotifier {
  TextEditingController nameTaskController = TextEditingController();

  TextEditingController taskDescController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isHighPriority = false;

  void addTask(BuildContext controllerContext) async {
    if (formKey.currentState?.validate() ?? false) {
      final taskJson = await SharedPreferencesManager().getString(
        StorgeKey.tasks,
      );

      List<dynamic> tasksList = [];

      if (taskJson != null) {
        tasksList = jsonDecode(taskJson);
      }

      TaskModel task = TaskModel(
        id: tasksList.length + 1,
        taskName: nameTaskController.text,
        taskDescription: taskDescController.text,
        isHighPriority: isHighPriority,
      );

      tasksList.add(task.toJson());
      final taskEncode = jsonEncode(tasksList);

      await SharedPreferencesManager().setString(StorgeKey.tasks, taskEncode);

      Navigator.of(controllerContext).pop(true);
    }

    notifyListeners();
  }

  void toggle (bool value){
    isHighPriority = value;

    notifyListeners();
  }
}
