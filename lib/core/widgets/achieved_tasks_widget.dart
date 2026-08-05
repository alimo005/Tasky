import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  AchievedTasksWidget({
    super.key,
    required this.totalTasks,
    required this.totalCompletedTasks,
    required this.percentage,
  });

  int totalTasks = 0;
  int totalCompletedTasks = 0;
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
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
                "$totalCompletedTasks Out of $totalTasks Done",
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
                    value: percentage,
                    // color: Color(0xff15B86C),
                    backgroundColor: Color(0xff6D6D6D),
                    valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                    strokeWidth: 4,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
              Text(
                "${(percentage * 100).toInt()}%",
                style: TextTheme.of(
                  context,
                ).labelSmall!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
