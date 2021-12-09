import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO (max):: immutable
class CustomButton extends StatelessWidget {
  // TODO (max)::  do noy late if they have a difualt value
  late double width;
  late double height;
  late double borderRadius;
  late double fontSize;
  late Color buttonColor;
  late VoidCallback onPressed;
  late String text;

  CustomButton({
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 10.0,
    this.fontSize = 20,
    this.buttonColor = const Color(0xffff745c),
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

// Widget customButton({
//   double width = double.infinity,
//   double height = 50,
//   double borderRadius = 10.0,
//   double fontSize = 20,
//   Color buttonColor = const Color(0xffff745c),
//   required onPressed,
//   required String text,
// }) =>
//     Container(
//       width: width,
//       decoration: BoxDecoration(
//         color: buttonColor,
//         borderRadius:
//             BorderRadiusDirectional.all(Radius.circular(borderRadius)),
//       ),
//       child: MaterialButton(
//         onPressed: onPressed,
//         height: height,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: fontSize,
//           ),
//         ),
//       ),
//     );
