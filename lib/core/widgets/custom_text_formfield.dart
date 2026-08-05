import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  CustomTextFormfield({
    super.key,
    required this.controller,
    required this.maxLines,
    required this.hint,
    this.validator,
    required this.titel
  });

  final TextEditingController controller;
  final int maxLines;
  final String hint;
  Function(String?)? validator;
  final String titel;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: 16),

        Text(
          titel,
          style: TextTheme.of(context).labelMedium,
        ),

        SizedBox(height: 20),

        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style:TextTheme.of(context).labelMedium,
          validator: validator != null ? (String? value)=>validator!(value) : null,
          decoration: InputDecoration(hintText: hint,),
        ),
      ],
    );
  }
}
