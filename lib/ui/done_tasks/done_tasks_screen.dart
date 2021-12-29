import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/common/components/no_tasks_page.dart';
import 'package:to_do/ui/done_tasks/cubit/done_tasks_cubit.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneTasksCubit, DoneTasksState>(
      builder: (context, state) {
        final doneCubit = BlocProvider.of<DoneTasksCubit>(context);
        if (state is DoneTasksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DoneTasksEmpty) {
          return NoTasksPage();
        } else if (state is GetDoneTasksSuccessfully) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final task = state.doneTasks[index];
                return CustomTasksListItem(
                  task: task,
                  onDoneIconPressed: () {},
                  onArchivedIconPressed: () => doneCubit.markAsArchived(task),
                  onDismissed: (direction) => doneCubit.deleteTask(task.id!),
                );
              },
              separatorBuilder: (_, __) => CustomListViewSeparator(),
              itemCount: state.doneTasks.length,
            ),
          );
        }
        throw state;
      },
    );
  }
}
