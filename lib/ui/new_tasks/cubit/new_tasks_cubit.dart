import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';
import 'package:to_do/ui/create_tasks/cubit/crud_cubit.dart';

part 'new_tasks_state.dart';

class NewTasksCubit extends Cubit<NewTasksState> {
  final TasksRepository tasksRepository;
  final CrudCubit crudCubit;
  late final StreamSubscription crudCubitSubscription;

  NewTasksCubit(this.tasksRepository, this.crudCubit)
      : super(NewTasksLoading()) {
    refreshNewTasks();
    crudCubitSubscription = crudCubit.stream.listen((state) {
      if (state is CrudSuccess) {
        refreshNewTasks();
      }
    });
  }

  Future<void> refreshNewTasks() async {
    emit(NewTasksLoading());
    try {
      final List<Task> tasks =
          await tasksRepository.getTasksFromDatabaseByStatus('new');
      if (tasks.isEmpty) {
        emit(NewTasksEmpty());
      } else {
        emit(GetNewTasksSuccessfully(tasks));
      }
    } catch (error) {
      emit(NewTasksError(error.toString()));
    }
  }

  Future<void> markTaskAsArchived(Task task) async {
    task.status = 'archived';
    await crudCubit.updateTask(task);
    refreshNewTasks();
  }

  Future<void> markTaskAsDone(Task task) async {
    task.status = 'done';
    await crudCubit.updateTask(task);
    refreshNewTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await crudCubit.deleteTask(taskId);
    refreshNewTasks();
  }

  @override
  Future<void> close() {
    crudCubitSubscription.cancel();
    return super.close();
  }
}
