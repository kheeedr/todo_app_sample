part of 'done_tasks_cubit.dart';

@immutable
abstract class DoneTasksState {}

class DoneTasksLoading extends DoneTasksState {}

class GetDoneTasksSuccessfully extends DoneTasksState {
  final List<Task> _doneTasks;

  List<Task> get doneTasks => _doneTasks;

  GetDoneTasksSuccessfully(this._doneTasks);
}

class DoneTasksError extends DoneTasksState {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  DoneTasksError(this._errorMessage);
}
