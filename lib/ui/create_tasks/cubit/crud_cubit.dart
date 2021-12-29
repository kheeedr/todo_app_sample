import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

part 'create_tasks_state.dart';

class CrudCubit extends Cubit<CrudState> {
  final TasksRepository tasksRepository;

  CrudCubit(this.tasksRepository) : super(CrudInitial());

  Future<void> insertTask(Task task) async {
    try {
      emit(CrudLoading());
      await tasksRepository.insertTask(task);
      // TODO :: refresh home with BLOC TO BLOC
      emit(CrudSuccess());
    } catch (error) {
      emit(CrudError(error: error.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await tasksRepository.updateTask(task);
      emit(CrudSuccess());
      if (task.status == 'done') {
        emit(CrudDone());
      } else if (task.status == 'archived') {
        emit(CrudArchived());
      }
    } catch (error) {
      emit(CrudError(error: error.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await tasksRepository.deleteTask(id);
      emit(CrudSuccess());
    } catch (error) {
      emit(CrudError(error: error.toString()));
    }
  }
}
