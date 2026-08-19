import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/task_item_widget.dart';
import 'package:tasky/features/home_feature/home_controller.dart';

class TasksListSlivers extends StatelessWidget {
  const TasksListSlivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return controller.taskList.isEmpty
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
                    itemCount: controller.taskList.length,

                    itemBuilder: (BuildContext context, int index) {
                      return TaskItemWidget(
                        model: controller.taskList[index],
                        onChanged: (bool? value) {
                          controller.doneTask(value, index);
                        },
                        onDelete: (int? id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () {
                          controller.loadTask();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 8);
                    },
                  );
          },
    );
  }
}
