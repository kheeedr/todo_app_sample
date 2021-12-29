import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final double borderRadius;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String> validator;
  final TextInputType inputType;
  final bool isPassword;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;

  const CustomTextFormField({
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
