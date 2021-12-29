part of '../../../ui/archived_tasks/cubit/archived_tasks_cubit.dart';

@immutable
abstract class ArchivedTasksState {}

class ArchivedTasksEmpty extends ArchivedTasksState {}

class ArchivedTasksLoading extends ArchivedTasksState {}

class GetArchivedTasksSuccessfully extends ArchivedTasksState {
  final List<Task> archivedTasks;

  GetArchivedTasksSuccessfully(this.archivedTasks);
}

class ArchivedTasksError extends ArchivedTasksState {
  final String errorMessage;

  ArchivedTasksError(this.errorMessage);
}
