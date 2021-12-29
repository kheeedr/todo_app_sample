import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/common/components/no_tasks_page.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/ui/archived_tasks/cubit/archived_tasks_cubit.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchivedTasksCubit, ArchivedTasksState>(
      builder: (context, state) {
        final archivedCubit = BlocProvider.of<ArchivedTasksCubit>(context);

        if (state is ArchivedTasksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ArchivedTasksEmpty) {
          return NoTasksPage();
        } else if (state is ArchivedTasksError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetArchivedTasksSuccessfully) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final Task task = state.archivedTasks[index];
                return CustomTasksListItem(
                  task: task,
                  onDoneIconPressed: () => archivedCubit.markAsDone(task),
                  onDismissed: (_) => archivedCubit.deleteTask(task.id!),
                  onArchivedIconPressed: () {},
                );
              },
              separatorBuilder: (_, __) => CustomListViewSeparator(),
              itemCount: state.archivedTasks.length,
            ),
          );
        }
        throw state;
      },
    );
  }
}
