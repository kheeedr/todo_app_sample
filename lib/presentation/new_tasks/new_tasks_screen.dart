// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/business_logic/cubit/new/new_tasks_cubit.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/data/model/task_model.dart';

class NewTasks extends StatelessWidget {
  List<Task> newTasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTasksCubit, NewTasksState>(
      listener: (context, state) {
        if (state is GetNewTasksSuccessfully) {
          newTasks = state.newTasks.reversed.toList();
        }
      },
      builder: (context, state) {
        NewTasksCubit cubit = NewTasksCubit.get(context)..getNewTasksFromDB();
        return (newTasks.isNotEmpty)
            ? ListView.separated(
                itemBuilder: (context, index) {
                  Task task = newTasks[index];
                  return CustomTasksListItem(
                    task: task,
                    onDoneIconPressed: () {
                      cubit.updateTask(Task(
                          id: task.id,
                          title: task.title,
                          date: task.date,
                          time: task.time,
                          status: 'done'));
                    },
                    onArchivedIconPressed: () {
                      cubit.updateTask(Task(
                          id: task.id,
                          title: task.title,
                          date: task.date,
                          time: task.time,
                          status: 'archived'));
                    },
                    onDismissed: (direction) {
                      cubit.deleteTask(task.id!);
                    },
                  );
                },
                separatorBuilder: (_, __) => CustomListViewSeparator(),
                itemCount: newTasks.length,
              )
            : NoTasksPage();
      },
    );
  }
}
