import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home_feature/home_controller.dart';
import '../../core/widgets/custom_svg_image.dart';
import '../../core/widgets/tasks_list_slivers.dart';
import '../add_task_feature/add_task.dart';
import 'componants/achieved_tasks_widget.dart';
import 'componants/high_priority_tasks_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>HomeController()..initState(),
      child: SafeArea(
        child: Consumer<HomeController>(

           builder: (BuildContext context, value, Widget? child) {
             final controller = context.read<HomeController>();

             return Scaffold(
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
                       controller.loadTask();
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
                                   backgroundImage: value.imagePath==null ?AssetImage(
                                     "asesst/image/logoHomePage.png",
                                   ) : FileImage(File(value.imagePath!))
                               ),
                               SizedBox(width: 8),
                               Padding(
                                 padding: const EdgeInsets.only(top: 4, bottom: 4),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       'Good Evening ,${value.userName} ',
                                       style: TextTheme.of(context).displaySmall,
                                     ),
                                     Text(
                                       value.quote ?? "No quote yet",
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
                             totalTasks: value.totalTasks,
                             totalCompletedTasks: value.totalCompletedTasks,
                             percentage: value.percentage,
                           ),
                           SizedBox(height: 16),
                           HighPriorityTasksWidget(
                             taskList: value.taskList,
                             onTap: (bool? value, int? index) {
                               controller.highPriorityCheck(value, index);
                             },
                             refresh: () {
                               controller.loadTask();
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
                       taskList: value.taskList,
                       onTap: (bool? value, int? index) async {
                         controller.highPriorityCheck(value, index);
                       }, onDelete: (int? id) {
                       controller.deleteTask(id);
                     }, onEdit: () {
                       controller.loadTask();
                     },
                     ),
                     SliverToBoxAdapter(child: SizedBox(height: 80)),
                   ],
                 ),
               ),
             );
           },

        ),
      ),
    );
  }
}
