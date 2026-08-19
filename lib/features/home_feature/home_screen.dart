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
      create: (_) => HomeController()..initState(),

      child: Builder(
        builder: (context) {
          final controller = context.read<HomeController>();
          return SafeArea(
            child: Scaffold(
              floatingActionButton: SizedBox(
                height: 44,
                child: Builder(
                  builder: (BuildContext controllerContext){
                    return FloatingActionButton.extended(
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
                          controllerContext.read<HomeController>().loadTask();
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add New Task'),
                    );
                  },
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
                              // ---------------- IMAGE ----------------
                              Selector<HomeController, String?>(
                                selector: (context, controller) =>
                                controller.imagePath,

                                builder: (
                                    BuildContext context,
                                    String? pathImage,
                                    Widget? child,
                                    ) {
                                  return CircleAvatar(
                                    backgroundImage: pathImage == null
                                        ? const AssetImage(
                                      "asesst/image/logoHomePage.png",
                                    )
                                        : FileImage(
                                      File(pathImage),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(width: 8),

                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                ),

                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    // ---------------- USER NAME ----------------
                                    Selector<HomeController, String?>(
                                      selector: (context, controller) =>
                                      controller.userName,

                                      builder: (
                                          BuildContext context,
                                          String? userName,
                                          Widget? child,
                                          ) {
                                        return Text(
                                          'Good Evening, ${userName ?? ""}',
                                          style: TextTheme.of(
                                            context,
                                          ).displaySmall,
                                        );
                                      },
                                    ),

                                    // ---------------- QUOTE ----------------
                                    Selector<HomeController, String?>(
                                      selector: (context, controller) =>
                                      controller.quote,

                                      builder: (
                                          BuildContext context,
                                          String? quote,
                                          Widget? child,
                                          ) {
                                        return Text(
                                          quote ?? "No quote yet",
                                          style: TextTheme.of(
                                            context,
                                          ).labelSmall,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Yahoo, Your work Is',
                            style: TextTheme.of(context).displayLarge,
                          ),

                          Row(
                            children: [
                              Text(
                                'almost done!',
                                style: TextTheme.of(context).displayLarge,
                              ),

                              CustomSvgImage.withoutColor(
                                path:
                                "asesst/image/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg",
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          AchievedTasksWidget(),

                          const SizedBox(height: 16),

                          HighPriorityTasksWidget(),

                          const SizedBox(height: 50),

                          const Text(
                            "My Tasks",
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    TasksListSlivers(),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 80),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}