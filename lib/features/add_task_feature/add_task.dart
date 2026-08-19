import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/add_task_feature/add_task_controller.dart';
import '../../core/widgets/custom_text_formfield.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  @override
  Widget build(BuildContext _) {
print("Add Task Screen");
    return ChangeNotifierProvider(
      create: (_) =>AddTaskController(),
      builder: (context , _){
       final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormfield(
                    titel: "Task Name",
                    controller: controller.nameTaskController,
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
                    controller: controller.taskDescController,
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

                      Consumer<AddTaskController>(
                        builder: (BuildContext context, AddTaskController value, Widget? child) {
                          print("Switch");
                          return Switch(
                            value: value.isHighPriority,
                            onChanged: (bool value) {
                              controller.toggle(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Spacer(),

                  Builder(
                      builder: (controllerContext) {
                        return ElevatedButton.icon(
                          onPressed: () async {
                            controllerContext.read<AddTaskController>().addTask(context);
                          },
                          icon: Icon(Icons.add),
                          label: Text('Add Task'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            fixedSize: Size(MediaQuery.of(context).size.width, 40),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
