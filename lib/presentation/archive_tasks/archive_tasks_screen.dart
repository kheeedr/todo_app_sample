// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/business_logic/cubit/archived/archived_tasks_cubit.dart';
import 'package:to_do/business_logic/cubit/home_cubit.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

class ArchivedTasks extends StatelessWidget {
  List<Task> archivedTasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivedTasksCubit(TasksRepository(TasksDB()))
        ..getArchivedTasksFromDB(),
      child: BlocConsumer<ArchivedTasksCubit, ArchivedTasksState>(
        listener: (context, state) {
          if (state is GetArchivedTasksSuccessfully) {
            archivedTasks = state.archivedTasks.reversed.toList();
          }
        },
        builder: (context, state) {
          ArchivedTasksCubit cubit = ArchivedTasksCubit.get(context);
          return (state is ArchivedTasksLoading)
              ? Center(child: CircularProgressIndicator())
              : (archivedTasks.isNotEmpty)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        Task task = archivedTasks[index];
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
                          onArchivedIconPressed: () {},
                          onDismissed: (direction) {
                            cubit.deleteTask(task.id!);
                          },
                        );
                      },
                      separatorBuilder: (_, __) => CustomListViewSeparator(),
                      itemCount: archivedTasks.length,
                    )
                  : NoTasksPage();
        },
      ),
    );
  }
}
