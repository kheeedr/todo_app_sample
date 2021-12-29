import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * (80 / 100),
            height: MediaQuery.of(context).size.width * (80 / 100),
            child: SvgPicture.asset('assets/images/pana.svg'),
          ),
          const Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
