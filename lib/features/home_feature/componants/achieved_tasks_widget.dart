import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home_feature/home_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  AchievedTasksWidget({super.key,});

  @override
  Widget build(BuildContext context) {

    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {

        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Achieved Tasks", style: TextTheme.of(context).displaySmall),
                  SizedBox(height: 4),
                  Text(
                    "${controller.totalCompletedTasks} Out of ${controller.totalTasks} Done",
                    style: TextTheme.of(context).labelSmall,
                  ),
                ],
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      height: 55,
                      width: 55,
                      child: CircularProgressIndicator(
                        value: controller.percentage,
                        // color: Color(0xff15B86C),
                        backgroundColor: Color(0xff6D6D6D),
                        valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                        strokeWidth: 4,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                  Text(
                    "${(controller.percentage * 100).toInt()}%",
                    style: TextTheme.of(
                      context,
                    ).labelSmall!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
