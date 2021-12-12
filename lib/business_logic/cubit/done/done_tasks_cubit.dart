import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

part 'done_tasks_state.dart';

class DoneTasksCubit extends Cubit<DoneTasksState> {
  final TasksRepository tasksRepository;

  DoneTasksCubit(this.tasksRepository) : super(DoneTasksInitial());

  static DoneTasksCubit get(context) => BlocProvider.of(context);

  Future updateTask(Task task) async {
    return await tasksRepository
        .updateTask(task)
        .then((_) => getDoneTasksFromDB())
        .catchError((error) => emit(DoneTasksError(error.toString())));
  }

  Future deleteTask(int id) async {
    return await tasksRepository
        .deleteTask(id)
        .then((_) => getDoneTasksFromDB())
        .catchError((error) => emit(DoneTasksError(error.toString())));
  }

  Future getDoneTasksFromDB() async {
    return await tasksRepository
        .getTasksFromDatabaseByStatus('done')
        .then((tasks) => emit(GetDoneTasksSuccessfully(tasks)))
        .catchError((error) => emit(DoneTasksError(error.toString())));
  }
}
