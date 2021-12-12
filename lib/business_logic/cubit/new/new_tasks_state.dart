part of 'new_tasks_cubit.dart';

@immutable
abstract class NewTasksState {}

class NewTasksLoading extends NewTasksState {}

class GetNewTasksSuccessfully extends NewTasksState {
  final List<Task> _newTasks;

  List<Task> get newTasks => _newTasks;

  GetNewTasksSuccessfully(this._newTasks);
}

class NewTasksError extends NewTasksState {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  NewTasksError(this._errorMessage);
}
