part of 'archived_tasks_cubit.dart';

@immutable
abstract class ArchivedTasksState {}

class ArchivedTasksLoading extends ArchivedTasksState {}

class GetArchivedTasksSuccessfully extends ArchivedTasksState {
  final List<Task> _archivedTasks;

  List<Task> get archivedTasks => _archivedTasks;

  GetArchivedTasksSuccessfully(this._archivedTasks);
}

class ArchivedTasksError extends ArchivedTasksState {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  ArchivedTasksError(this._errorMessage);
}
