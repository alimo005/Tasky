import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/todo_screen.dart';
import 'completed_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int? index) {
          setState(() {
            currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: buildSvgPicture("asesst/image/home.svg" , 0),
              label: "Home"),
          BottomNavigationBarItem(
            icon:buildSvgPicture("asesst/image/todo.svg",1),
            label: "To Do",
          ),

          BottomNavigationBarItem(
            icon:buildSvgPicture("asesst/image/completed.svg",2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon:buildSvgPicture("asesst/image/profile.svg" , 3),
            label: "Profile",
          ),
        ],
      ),

      body: screens[currentIndex],
    );
  }

  SvgPicture buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
