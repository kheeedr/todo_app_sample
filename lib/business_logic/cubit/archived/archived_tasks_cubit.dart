import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

part 'archived_tasks_state.dart';

class ArchivedTasksCubit extends Cubit<ArchivedTasksState> {
  final TasksRepository tasksRepository;

  static ArchivedTasksCubit get(context) => BlocProvider.of(context);

  ArchivedTasksCubit(this.tasksRepository) : super(ArchivedTasksLoading());

  Future updateTask(Task task) async {
    return await tasksRepository
        .updateTask(task)
        .then((_) => getArchivedTasksFromDB())
        .catchError((error) => emit(ArchivedTasksError(error.toString())));
  }

  Future deleteTask(int id) async {
    return await tasksRepository
        .deleteTask(id)
        .then((_) => getArchivedTasksFromDB())
        .catchError((error) => emit(ArchivedTasksError(error.toString())));
  }

  Future getArchivedTasksFromDB() async {
    return await tasksRepository
        .getTasksFromDatabaseByStatus('archived')
        .then((tasks) => emit(GetArchivedTasksSuccessfully(tasks)))
        .catchError((error) => emit(ArchivedTasksError(error.toString())));
  }
}
