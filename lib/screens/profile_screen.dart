import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/screens/user_details_screen.dart';
import '../core/services/sharedpreferences_manager.dart';
import '../core/widgets/custom_svg_image.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String motivation_quote = "";
  String? userImagePath;

  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      userName = SharedPreferencesManager().getString("userName") ?? "";
      motivation_quote = SharedPreferencesManager().getString("motivation_quote") ?? "";
      userImagePath = SharedPreferencesManager().getString("user_image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("My Profile", style: TextTheme.of(context).titleMedium),
        ),

        SizedBox(height: 24),

        Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: userImagePath == null
                        ? AssetImage("asesst/image/Thumbnail.png")
                        : FileImage(File(userImagePath!)),
                    backgroundColor: Colors.transparent,
                    radius: 60,
                  ),

                  GestureDetector(
                    onTap: () async {
                      final XFile? image =
                      await _showSimpleDialog_sourceImage(context);

                      if (image != null) {
                        setState(() {
                          userImagePath = image.path;
                        });

                        _saveImage(image);
                      }
                    },

                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.camera_alt, size: 26),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text(userName, style: TextTheme.of(context).titleMedium),

              SizedBox(height: 8),

              Text(motivation_quote, style: TextTheme.of(context).labelSmall),

              SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Profile Info",
                      style: TextTheme.of(context).displaySmall,
                    ),

                    SizedBox(height: 30),

                    ListTile(
                      onTap: () async {
                        final bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return UserDetailsScreen(
                                userName: userName,
                                motivation_quote: motivation_quote,
                              );
                            },
                          ),
                        );
                        if (result != null && result) {
                          _loadData();
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "User Details",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      leading: CustomSvgImage(path: "asesst/image/profile.svg"),
                      trailing: CustomSvgImage(path: "asesst/image/Icon.svg"),
                    ),

                    Divider(),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Dark Mode",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      leading: CustomSvgImage(path: "asesst/image/moon-01.svg"),
                      trailing: ValueListenableBuilder(
                        valueListenable: ThemeController.themeNotifier,
                        builder: (BuildContext context, value, Widget? child) {
                          return Switch(
                            value: value == ThemeMode.dark,
                            onChanged: (bool value) {
                              ThemeController().switchTheme();
                            },
                          );
                        },
                      ),
                    ),

                    Divider(
                      color: Color(0xff6E6E6E),
                      thickness: 1,
                      height: 1.0,
                    ),

                    ListTile(
                      onTap: () async {
                        _showAlertDialog_logOut(context);
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Log Out",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      leading: Icon(Icons.logout),
                      trailing: CustomSvgImage(path: "asesst/image/Icon.svg"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
   final image =  await File(file.path).copy('${appDir.path}/${file.name}');
    SharedPreferencesManager().setString("user_image", image.path);
  }
}

_showAlertDialog_logOut(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Log Out"),
        content: Text("Are you sure,you want log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              SharedPreferencesManager().remove("userName");
              SharedPreferencesManager().remove("motivation_quote");
              SharedPreferencesManager().remove("tasks");
              SharedPreferencesManager().remove("user_image");

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LogIn_Screen();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text("log out", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

Future<XFile?> _showSimpleDialog_sourceImage(BuildContext context) {
 return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text("Source Image", style: TextTheme.of(context).labelMedium),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(8),
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if(image != null){
                Navigator.pop(context , image);
              }

            },
            child: Row(
              children: [
                Icon(Icons.camera_alt_sharp),
                SizedBox(width: 8),
                Text("Camera", style: TextTheme.of(context).labelMedium),
              ],
            ),
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(8),

            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );

              if(image != null){
                Navigator.pop(context,image);
              }


            },
            child: Row(
              children: [
                Icon(Icons.photo_library_outlined),
                SizedBox(width: 8),
                Text("Galary", style: TextTheme.of(context).labelMedium),
              ],
            ),
          ),
        ],
      );
    },
  );
}
