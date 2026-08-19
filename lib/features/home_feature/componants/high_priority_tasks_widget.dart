import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/home_feature/home_controller.dart';
import '../../tasks_feature/high_priority_tasks_screen.dart';
import '../../../core/widgets/custom_check_box.dart';
import '../../../core/widgets/custom_svg_image.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  HighPriorityTasksWidget({super.key,});


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "High Priority Tasks",
                          style: TextTheme.of(
                            context,
                          ).labelSmall!.copyWith(color: Color(0xFF15B86C)),
                        ),
                      ),
                      SizedBox(height: 8),
                      ...controller.taskList.where((e) => e.isHighPriority).take(4).map((
                          element,
                          ) {
                        return Container(
                          child: Row(
                            children: [
                              CustomCheckBox(
                                value: element.isDone,
                                onChanged: (bool? value) {
                                  final index = controller.taskList.indexWhere((e) => e.id == element.id,);
                                  controller.doneTask(value, index);
                                },
                              ),

                              Text(
                                element.taskName,
                                style: TextTheme.of(context).displaySmall,

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 56,
                    width: 48,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeController.isDark()
                          ? Color(0xFF282828)
                          : Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeController.isLight()
                            ? Color(0xFFD1DAD6)
                            : Color(0xFF6E6E6E),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HighPriorityTasksScreen();
                              },
                            ),
                          );
                          controller.loadTask();
                        },
                        child:CustomSvgImage(
                          path: 'asesst/image/Icon (1).svg',
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
