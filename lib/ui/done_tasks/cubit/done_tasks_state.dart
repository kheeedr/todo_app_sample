part of 'done_tasks_cubit.dart';

@immutable
abstract class DoneTasksState {}

class DoneTasksLoading extends DoneTasksState {}

class DoneTasksEmpty extends DoneTasksState {}

class GetDoneTasksSuccessfully extends DoneTasksState {
  final List<Task> doneTasks;

  GetDoneTasksSuccessfully(this.doneTasks);
}

class DoneTasksError extends DoneTasksState {
  final String errorMessage;

  DoneTasksError(this.errorMessage);
}
