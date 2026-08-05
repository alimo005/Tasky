import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/models/taskModel.dart';

import '../enums/tasks_actions_enum.dart';
import '../services/sharedpreferences_manager.dart';
import 'custom_check_box.dart';
import 'custom_text_formfield.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit
  });

  TaskModel model;

  Function(bool?) onChanged;
  Function(int?) onDelete;
  Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeController.isDark()
                ? Colors.transparent
                : Color(0xFFD1DAD6),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CustomCheckBox(
              value: model.isDone,
              onChanged: (bool? value) {
                onChanged(value);
              },
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.taskName,
                      style: model.isDone
                          ? TextTheme.of(context).bodySmall
                          : TextTheme.of(context).labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (model.taskDescription.isNotEmpty && !model.isDone)
                      Text(
                        model.taskDescription,
                        style: TextTheme.of(context).labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<TaskItemActionsEnum>(
              icon: Icon(Icons.more_vert),

              itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
                return PopupMenuItem(
                  value: e  ,
                  child: Text(e.title, style: TextStyle(fontSize: 12)),
                );
              }).toList(),
              
              onSelected: (value) async {
                switch (value) {
                  case TaskItemActionsEnum.markAsDone:
                    onChanged(!model.isDone);
                  case TaskItemActionsEnum.update:

                    final result = await _show_Bottom_Sheet(context, model);

                    if(result==true){
                      onEdit();
                    }
                  case TaskItemActionsEnum.delete:
                    await _showAlertDialog(context);
                }
              },

            ),
          ],
        ),
      ),
    );
  }

 _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure,you want delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              child: Text("Delete"),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

 Future<bool?> _show_Bottom_Sheet(BuildContext context, TaskModel model) {
    TextEditingController nameTaskController = TextEditingController(
      text: model.taskName,
    );

    TextEditingController taskDescController = TextEditingController(
      text: model.taskDescription,
    );

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    bool isHighPriority = false;

    return showModalBottomSheet<bool>(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context , void Function(void Function()) setState){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
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
                          style: TextTheme.of(context).labelMedium
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
                              final taskJson = await SharedPreferencesManager().getString("tasks");

                               List<dynamic> tasksList = [];

                              if (taskJson != null) {
                                tasksList = jsonDecode(taskJson);
                              }

                              TaskModel taskAfterEdit = TaskModel(
                                id: model.id,
                                taskName: nameTaskController.text,
                                taskDescription: taskDescController.text,
                                isHighPriority: isHighPriority,
                              );

                              final item = tasksList.firstWhere(
                                  (e) => e['id'] == model.id
                              );

                              final int index =tasksList.indexOf(item);
                              tasksList[index] = taskAfterEdit;

                              final taskEncode = jsonEncode(tasksList);

                              await SharedPreferencesManager().setString("tasks",taskEncode,);

                              Navigator.of(context).pop(true);
                        }
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Edit Task'),
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
            );
          },
        );

      },
    );
  }
}
