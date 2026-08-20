import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../models/taskModel.dart';

class TasksController extends ChangeNotifier {
  List<TaskModel> tasks = [];

  List<TaskModel> toDoTasks = [];

  List<TaskModel> completedTasks = [];

  List<TaskModel> highPriorityTasksList = [];

  init() {
    loadTasks();
  }

  void loadTasks() {
    final taskEnCode = SharedPreferencesManager().getString(StorgeKey.tasks);

    if (taskEnCode != null) {
      final taskAfterDecode = jsonDecode(taskEnCode) as List<dynamic>;

      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();

      toDoTasks = tasks.where((e) => !e.isDone).toList();

      completedTasks = tasks.where((e) => e.isDone).toList();

      highPriorityTasksList = tasks.where((e) => e.isHighPriority).toList();

      highPriorityTasksList = highPriorityTasksList.reversed.toList();
    }
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;

    toDoTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == toDoTasks[index].id);

    tasks[newIndex] = toDoTasks[index];

    await SharedPreferencesManager().setString(
      StorgeKey.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }

  void doneCompletedTask(bool? value, int? index) async {
    if (index == null) return;

    completedTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == completedTasks[index].id,
    );

    tasks[newIndex] = completedTasks[index];

    await SharedPreferencesManager().setString(
      StorgeKey.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }

  void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;

    highPriorityTasksList[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasksList[index].id,
    );

    tasks[newIndex] = highPriorityTasksList[index];

    await SharedPreferencesManager().setString(
      StorgeKey.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);

    toDoTasks.removeWhere((taskList) => taskList.id == id);

    completedTasks.removeWhere((taskList) => taskList.id == id);
    highPriorityTasksList.removeWhere((taskList) => taskList.id == id);

    final upDatedTask = tasks.map((element) => element.toJson()).toList();

    SharedPreferencesManager().setString(
      StorgeKey.tasks,
      jsonEncode(upDatedTask),
    );

    notifyListeners();
  }

}
