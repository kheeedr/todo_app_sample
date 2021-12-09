part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

// TODO (max)::  the bloc must handle single state changes ONLY ONE
class HomeInitial extends HomeState {}

class BottomNavNewTask extends HomeState {}

class BottomNavDoneTask extends HomeState {}

class BottomNavArchivedTask extends HomeState {}

class BottomSheetOpened extends HomeState {}

class BottomSheetClosed extends HomeState {}

class TaskSavedSuccessfully extends HomeState {}

class ErrorOnSaveTask extends HomeState {}

class ErrorOnGetTasks extends HomeState {}

class DataRetrievedFromDB extends HomeState {}

class TaskUpdatedSuccessfully extends HomeState {}

class ErrorOnUpdateTask extends HomeState {}

class TaskDeletedSuccessfully extends HomeState {}

class ErrorOnDeleteTask extends HomeState {}
