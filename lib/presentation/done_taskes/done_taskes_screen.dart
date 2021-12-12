import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/business_logic/cubit/done/done_tasks_cubit.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

class DoneTasks extends StatelessWidget {
  List<Task> doneTasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DoneTasksCubit(TasksRepository(TasksDB()))..getDoneTasksFromDB(),
      child: BlocConsumer<DoneTasksCubit, DoneTasksState>(
        listener: (context, state) {
          if (state is GetDoneTasksSuccessfully) {
            doneTasks = state.doneTasks.reversed.toList();
          }
        },
        builder: (context, state) {
          DoneTasksCubit cubit = DoneTasksCubit.get(context);
          return (state is DoneTasksLoading)
              ? Center(child: CircularProgressIndicator())
              : (doneTasks.isNotEmpty)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        Task task = doneTasks[index];
                        return CustomTasksListItem(
                          task: task,
                          onDoneIconPressed: () {},
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
                      itemCount: doneTasks.length,
                    )
                  : NoTasksPage();
        },
      ),
    );
  }
}
