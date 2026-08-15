import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/models/taskModel.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/custom_svg_image.dart';
import '../../core/widgets/tasks_list_slivers.dart';
import '../add_task_feature/add_task.dart';
import 'componants/achieved_tasks_widget.dart';
import 'componants/high_priority_tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  List<TaskModel> taskList = [];

  int totalTasks = 0;
  int totalCompletedTasks = 0;
  double percentage = 0.0;
  String quote = "";
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadName();
    _loadTask();
  }

  void _loadName() async {
    setState(() {
      userName = SharedPreferencesManager().getString("userName");
      imagePath = SharedPreferencesManager().getString("user_image");
    });
  }

  void _loadTask() async {
    final taskEnCode = SharedPreferencesManager().getString("tasks");

    if (taskEnCode != null) {
      final taskAfterDecode = jsonDecode(taskEnCode) as List<dynamic>;

      final taskFinal = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      setState(() {
        taskList = taskFinal;
        _percentage();
        _loadQuote();
      });
    }
  }

  void _loadQuote() async {
    quote = SharedPreferencesManager().getString("motivation_quote") ?? "";
  }

  void _percentage() {
    totalTasks = taskList.length;
    totalCompletedTasks = taskList.where((e) => e.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalCompletedTasks / totalTasks;
  }

  void highPriorityCheck(bool? value, int? index) async {
    setState(() {
      taskList[index!].isDone = value ?? false;
      _percentage();
    });
    final updatedData = taskList.map((element) => element.toJson()).toList();
    SharedPreferencesManager().setString("tasks", jsonEncode(updatedData));
  }

    _deleteTask(int? id)async{
    if(id==null)return;
    setState(() {
      taskList.removeWhere((taskList) => taskList.id==id);
      _percentage();
    });

    final upDatedTask = taskList.map((element) => element.toJson()).toList();
    SharedPreferencesManager().setString("tasks", jsonEncode(upDatedTask));

    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 40,
          child: FloatingActionButton.extended(
            onPressed: () async {
              final bool? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddTask();
                  },
                ),
              );
              if (result != null && result) {
                _loadTask();
              }
            },
            icon: Icon(Icons.add),
            label: Text('Add New Task'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: imagePath==null ?AssetImage(
                            "asesst/image/logoHomePage.png",
                          ) : FileImage(File(imagePath!))
                        ),
                        SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Evening ,${userName} ',
                                style: TextTheme.of(context).displaySmall,
                              ),
                              Text(
                                quote ?? "No quote yet",
                                style: TextTheme.of(context).labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Yahoo ,Your work Is ',
                      style: TextTheme.of(context).displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: TextTheme.of(context).displayLarge,
                        ),
                        CustomSvgImage.withoutColor(
                          path:
                              "asesst/image/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg",
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    AchievedTasksWidget(
                      totalTasks: totalTasks,
                      totalCompletedTasks: totalCompletedTasks,
                      percentage: percentage,
                    ),
                    SizedBox(height: 16),
                    HighPriorityTasksWidget(
                      taskList: taskList,
                      onTap: (bool? value, int? index) {
                        highPriorityCheck(value, index);
                      },
                      refresh: () {
                        _loadTask();
                      },
                    ),
                    SizedBox(height: 50),
                    Text(
                      "My Tasks",
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              TasksListSlivers(
                taskList: taskList,
                onTap: (bool? value, int? index) async {
                  highPriorityCheck(value, index);
                }, onDelete: (int? id) {
                _deleteTask(id);
              }, onEdit: () {
                  _loadTask();
              },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }
}
