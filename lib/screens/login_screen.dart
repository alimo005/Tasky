import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/services/sharedpreferences_manager.dart';
import '../core/widgets/custom_svg_image.dart';
import '../core/widgets/custom_text_formfield.dart';
import 'main_screen.dart';

class LogIn_Screen extends StatelessWidget {
  LogIn_Screen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgImage.withoutColor(
                    path:"asesst/image/Vector.svg",
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Tasky',
                    style:TextTheme.of(context).displayMedium
                  ),
                ],
              ),
              SizedBox(height: 108),

              // Welcome Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Tasky ",
                    style:TextTheme.of(context).displayMedium!.copyWith(
                      fontSize: 24
                    )
                  ),
                  CustomSvgImage.withoutColor(path: "asesst/image/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg")
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Your productivity journey starts here.",
                style:TextTheme.of(context).displaySmall

              ),
              SizedBox(height: 24),

              // Illustration
              CustomSvgImage.withoutColor(path: "asesst/image/pana.svg"),
              SizedBox(height: 32),

              // Form Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label
                    SizedBox(height: 8),

                    CustomTextFormfield(
                      controller: controller,
                      maxLines: 1,
                      hint: 'your Name',
                      titel: 'Full Name',
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Pleas enter your Name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          SharedPreferencesManager().setString(
                            "userName",
                            controller.value.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Login successful, welcome!",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              behavior: SnackBarBehavior.fixed,
                              showCloseIcon: true,
                              backgroundColor: Color(0xFF121212),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MainScreen();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pleas enter your Name"),
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                              backgroundColor: Color(0xFFCF6679),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: Size(MediaQuery.of(context).size.width, 45),
                      ),
                      child: Text(
                        "Let's Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
