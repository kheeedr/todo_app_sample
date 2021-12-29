import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';
import 'package:to_do/ui/create_tasks/cubit/crud_cubit.dart';

part 'archived_tasks_state.dart';

class ArchivedTasksCubit extends Cubit<ArchivedTasksState> {
  final TasksRepository tasksRepository;
  final CrudCubit crudCubit;
  late final StreamSubscription crudCubitSubscription;

  ArchivedTasksCubit(this.tasksRepository, this.crudCubit)
      : super(ArchivedTasksLoading()) {
    refreshArchivedTasks();
    crudCubitSubscription = crudCubit.stream.listen((state) {
      if (state is CrudArchived) {
        refreshArchivedTasks();
      }
    });
  }

  Future<void> refreshArchivedTasks() async {
    emit(ArchivedTasksLoading());
    try {
      final List<Task> tasks =
          await tasksRepository.getTasksFromDatabaseByStatus('archived');
      if (tasks.isEmpty) {
        emit(ArchivedTasksEmpty());
      } else {
        emit(GetArchivedTasksSuccessfully(tasks));
      }
    } catch (error) {
      emit(ArchivedTasksError(error.toString()));
    }
  }

  Future<void> markAsDone(Task task) async {
    task.status = 'done';
    await crudCubit.updateTask(task);
    refreshArchivedTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await crudCubit.deleteTask(taskId);
    refreshArchivedTasks();
  }

  @override
  Future<void> close() {
    crudCubitSubscription.cancel();
    return super.close();
  }
}
