import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storge_key.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/login_feature/login_screen.dart';
import 'package:tasky/features/navegation_feature/main_screen.dart';
import 'core/services/sharedpreferences_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesManager().init();

  String? userName = SharedPreferencesManager().getString(StorgeKey.userName);

  ThemeController().init();

  runApp(Tasky(userName: userName));
}

class Tasky extends StatelessWidget {
  const Tasky({super.key, required this.userName});
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeController.themeNotifier.value,
          debugShowCheckedModeBanner: false,
          home: userName == null
              ? LogIn_Screen()
              : SafeArea(child: MainScreen()),
        );
      },
    );
  }
}
