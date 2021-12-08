// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/business_logic/cubit/home_cubit.dart';
import 'package:to_do/data/model/task_model.dart';

class TasksListViewBuilder extends StatelessWidget {
  HomeCubit cubit;
  List<Task> tasks;

  TasksListViewBuilder({
    required this.cubit,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return (tasks.isNotEmpty)
        ? ListView.separated(
            itemBuilder: (context, index) => TaskItem(
                  task: tasks.reversed.toList()[index],
                  cubit: cubit,
                ),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
            itemCount: tasks.length)
        : Center(
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

class TaskItem extends StatelessWidget {
  Task task;
  HomeCubit cubit;

  TaskItem({
    required this.task,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        cubit.deleteTask(task.id!);
      },
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
              onPressed: () {
                cubit.updateTask(Task(
                    id: task.id,
                    title: task.title,
                    date: task.date,
                    time: task.time,
                    status: 'done'));
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            ),
            IconButton(
              iconSize: 35,
              onPressed: () {
                cubit.updateTask(Task(
                    id: task.id,
                    title: task.title,
                    date: task.date,
                    time: task.time,
                    status: 'archived'));
              },
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
