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
