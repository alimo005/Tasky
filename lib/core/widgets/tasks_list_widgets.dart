import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/task_item_widget.dart';
import 'package:tasky/models/taskModel.dart';

class TasksListWidgets extends StatelessWidget {
  const TasksListWidgets({
    super.key,
    required this.taskList,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final List<TaskModel> taskList;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
final  Function() onEdit;


  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? Center(
            child: Text(
              "No Data",
              style: TextTheme.of(context).labelMedium!.copyWith(fontSize: 20),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 60),
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: taskList[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onDelete: (int? id) {
                  onDelete(id);
                }, onEdit: () {
                  onEdit();
              },
              );
            },
          );
  }
}
