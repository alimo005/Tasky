import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/taskModel.dart';
import '../../core/constants/storge_key.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/custom_text_formfield.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameTaskController = TextEditingController();

  TextEditingController taskDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormfield(
                titel: "Task Name",
                controller: nameTaskController,
                maxLines: 1,
                hint: 'Task Name',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pleas enter Task Name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              CustomTextFormfield(
                titel: "Task Description",
                controller: taskDescController,
                maxLines: 5,
                hint: 'Task Description (optional)',
              ),

              SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'High Priority',
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Switch(
                    value: isHighPriority,
                    onChanged: (bool value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
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

                    await SharedPreferencesManager().setString(
                      StorgeKey.tasks,
                      taskEncode,
                    );

                    Navigator.of(context).pop(true);
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
