import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/task_item_widget.dart';

import '../../models/taskModel.dart';
class TasksListSlivers extends StatelessWidget {
  const TasksListSlivers({
    super.key,
    required this.taskList,
    required this.onTap,
    required this.onEdit,
    required this.onDelete
  });

  final List<TaskModel> taskList;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
 final Function() onEdit;



  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No Data",
                style: TextTheme.of(
                  context,
                ).labelMedium!.copyWith(fontSize: 20),
              ),
            ),
          )
        : SliverList.separated(
            itemCount: taskList.length,

            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(model: taskList[index], onChanged: (bool? value) {
                onTap(value,index);
              }, onDelete: (int? id) {
                onDelete(id);

              }, onEdit: () {
                onEdit();
              },);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
