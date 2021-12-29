part of 'new_tasks_cubit.dart';

@immutable
abstract class NewTasksState {}

class NewTasksEmpty extends NewTasksState {}

class NewTasksLoading extends NewTasksState {}

class GetNewTasksSuccessfully extends NewTasksState {
  final List<Task> newTasks;

  GetNewTasksSuccessfully(this.newTasks);
}

class NewTasksError extends NewTasksState {
  final String errorMessage;

  NewTasksError(this.errorMessage);
}
