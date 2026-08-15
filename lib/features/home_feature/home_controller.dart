import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../models/taskModel.dart';

class HomeController extends ChangeNotifier {
  String? userName;

  List<TaskModel> taskList = [];

  int totalTasks = 0;
  int totalCompletedTasks = 0;
  double percentage = 0.0;
  String quote = "";
  String? imagePath;

  void initState() {
    loadName();
    loadTask();
  }

  void loadName() async {
    userName = SharedPreferencesManager().getString(StorgeKey.userName);
    imagePath = SharedPreferencesManager().getString("user_image");

    notifyListeners();
  }

  void loadTask() async {
    final taskEnCode = SharedPreferencesManager().getString("tasks");

    if (taskEnCode != null) {
      final taskAfterDecode = jsonDecode(taskEnCode) as List<dynamic>;

      final taskFinal = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      taskList = taskFinal;
      percentage_fun();
      loadQuote();
    }

    notifyListeners();

  }

  void loadQuote() async {
    quote = SharedPreferencesManager().getString("motivation_quote") ?? "";
    notifyListeners();

  }

  void percentage_fun() {
    totalTasks = taskList.length;
    totalCompletedTasks = taskList.where((e) => e.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalCompletedTasks / totalTasks;
    notifyListeners();

  }

  void highPriorityCheck(bool? value, int? index) async {
    taskList[index!].isDone = value ?? false;
    percentage_fun();

    final updatedData = taskList.map((element) => element.toJson()).toList();
    SharedPreferencesManager().setString("tasks", jsonEncode(updatedData));

    notifyListeners();

  }

  deleteTask(int? id) async {
    if (id == null) return;
    taskList.removeWhere((taskList) => taskList.id == id);
    percentage_fun();

    final upDatedTask = taskList.map((element) => element.toJson()).toList();
    SharedPreferencesManager().setString("tasks", jsonEncode(upDatedTask));

    notifyListeners();

  }
}
