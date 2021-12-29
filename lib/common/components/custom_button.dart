import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final Color buttonColor;
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 10.0,
    this.fontSize = 20,
    this.buttonColor = Colors.deepPurple,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius:
            BorderRadiusDirectional.all(Radius.circular(borderRadius)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
