import 'package:flutter/material.dart';
import '../../core/services/sharedpreferences_manager.dart';
import '../../core/widgets/custom_text_formfield.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({super.key , required this.userName , required this.motivation_quote});

  String? userName = "" ;
  String? motivation_quote = "" ;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();


}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  void initState() {
    super.initState();
    userNameController.text=widget.userName!;
    motivationController.text = widget.motivation_quote!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormfield(
                titel: "User Name",
                controller: userNameController,
                maxLines: 1,
                hint: 'Enter User Name',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pleas enter User Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomTextFormfield(
                titel: "Motivation Quote",
                controller: motivationController,
                maxLines: 5,
                hint: 'Motivation Quote',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pleas enter Motivation Quote';
                  }
                  return null;
                },
              ),

              Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 46),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    SharedPreferencesManager().setString("userName", userNameController.value.text);

                    SharedPreferencesManager().setString("motivation_quote", motivationController.value.text);

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
