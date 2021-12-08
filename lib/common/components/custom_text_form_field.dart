import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  double borderRadius;
  String label;
  Widget? prefixIcon;
  Widget? suffixIcon;
  final FormFieldValidator<String> validator;
  TextInputType inputType;
  bool isPassword;
  VoidCallback? onTap;
  TextEditingController? controller;
  bool readOnly;

  CustomTextFormField({
    this.controller,
    this.borderRadius = 10.0,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    required this.label,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: isPassword,
      keyboardType: inputType,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
      ),
    );
  }
}
