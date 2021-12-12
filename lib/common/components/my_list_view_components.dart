// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/business_logic/cubit/new/new_tasks_cubit.dart';
import 'package:to_do/data/model/task_model.dart';

// TODO (max):: immutable

class CustomTasksListItem extends StatelessWidget {
  final Task task;
  final DismissDirectionCallback onDismissed;
  final VoidCallback onDoneIconPressed;
  final VoidCallback onArchivedIconPressed;

  CustomTasksListItem({
    required this.task,
    required this.onDismissed,
    required this.onDoneIconPressed,
    required this.onArchivedIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      key: Key(task.id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 40,
              child: Text(
                task.time,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    task.date,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 35,
              onPressed: onDoneIconPressed,
              icon: Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            ),
            IconButton(
              iconSize: 35,
              onPressed: onArchivedIconPressed,
              icon: Icon(
                Icons.archive,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListViewSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey[400],
    );
  }
}
