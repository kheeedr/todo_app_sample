import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/common/components/my_list_view_components.dart';
import 'package:to_do/common/components/no_tasks_page.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/ui/new_tasks/cubit/new_tasks_cubit.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTasksCubit, NewTasksState>(
      builder: (context, state) {
        final newTasksCubit = BlocProvider.of<NewTasksCubit>(context);
        if (state is NewTasksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewTasksEmpty) {
          return NoTasksPage();
        } else if (state is NewTasksError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetNewTasksSuccessfully) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final Task task = state.newTasks[index];
                return CustomTasksListItem(
                  task: task,
                  onDoneIconPressed: () => newTasksCubit.markTaskAsDone(task),
                  onArchivedIconPressed: () =>
                      newTasksCubit.markTaskAsArchived(task),
                  onDismissed: (_) => newTasksCubit.deleteTask(task.id!),
                );
              },
              separatorBuilder: (_, __) => CustomListViewSeparator(),
              itemCount: state.newTasks.length,
            ),
          );
        }
        throw state;
      },
    );
  }
}
