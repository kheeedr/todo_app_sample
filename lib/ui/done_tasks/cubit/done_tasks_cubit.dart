import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';
import 'package:to_do/ui/create_tasks/cubit/crud_cubit.dart';

part 'done_tasks_state.dart';

class DoneTasksCubit extends Cubit<DoneTasksState> {
  final TasksRepository tasksRepository;

  final CrudCubit crudCubit;
  late final StreamSubscription crudCubitSubscription;

  DoneTasksCubit(this.tasksRepository, this.crudCubit)
      : super(DoneTasksLoading()) {
    refreshDoneTasks();
    crudCubitSubscription = crudCubit.stream.listen((state) {
      if (state is CrudDone) {
        refreshDoneTasks();
      }
    });
  }

  Future<void> refreshDoneTasks() async {
    try {
      final List<Task> tasks =
          await tasksRepository.getTasksFromDatabaseByStatus('done');
      if (tasks.isEmpty) {
        emit(DoneTasksEmpty());
      } else {
        emit(GetDoneTasksSuccessfully(tasks));
      }
    } catch (error) {
      emit(DoneTasksError(error.toString()));
    }
  }

  Future<void> markAsArchived(Task task) async {
    task.status = 'archived';
    await crudCubit.updateTask(task);
    refreshDoneTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await crudCubit.deleteTask(taskId);
    refreshDoneTasks();
  }

  @override
  Future<void> close() {
    crudCubitSubscription.cancel();
    return super.close();
  }
}
