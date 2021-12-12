import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

part 'new_tasks_state.dart';

class NewTasksCubit extends Cubit<NewTasksState> {
  final TasksRepository tasksRepository;

  NewTasksCubit(this.tasksRepository) : super(NewTasksInitial());

  static NewTasksCubit get(context) => BlocProvider.of(context);

  Future insertToTasksTable(Task task) async {
    return await tasksRepository
        .insertTask(task)
        .then((_) => getNewTasksFromDB())
        .catchError((error) => emit(NewTasksError(error.toString())));
  }

  Future updateTask(Task task) async {
    return await tasksRepository
        .updateTask(task)
        .then((_) => getNewTasksFromDB())
        .catchError((error) => emit(NewTasksError(error.toString())));
  }

  Future deleteTask(int id) async {
    return await tasksRepository
        .deleteTask(id)
        .then((value) => getNewTasksFromDB())
        .catchError((error) => emit(NewTasksError(error.toString())));
  }

  Future getNewTasksFromDB() async {
    return await tasksRepository
        .getTasksFromDatabaseByStatus('new')
        .then((tasks) => emit(GetNewTasksSuccessfully(tasks)))
        .catchError((error) => emit(NewTasksError(error.toString())));
  }
}
