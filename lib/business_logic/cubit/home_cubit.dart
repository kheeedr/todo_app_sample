import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';
import 'package:to_do/presentation/archive_tasks/archive_tasks_screen.dart';
import 'package:to_do/presentation/done_taskes/done_taskes_screen.dart';
import 'package:to_do/presentation/new_tasks/new_tasks_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TasksRepository tasksRepository;

  HomeCubit(this.tasksRepository) : super(HomeInitial());

  int _navIndex = 0;

  int get navIndex => _navIndex;
  bool _isBottomSheetOpened = false;
  List<Task> allTasks = [];
  List<Task> newTasks = [];
  List<Task> doneTasks = [];
  List<Task> archivedTasks = [];

  final List<Widget> _screens = [NewTasks(), DoneTasks(), ArchiveTasks()];
  final List<String> _titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  static HomeCubit get(context) => BlocProvider.of(context);

  bool get isBottomSheetOpened => _isBottomSheetOpened;

  List<String> get titles => _titles;

  List<Widget> get screens => _screens;

  set navIndex(int value) {
    _navIndex = value;
    _isBottomSheetOpened = false;
    if (value == 0) {
      emit(BottomNavNewTask());
    } else if (value == 1) {
      emit(BottomNavDoneTask());
    } else if (value == 2) {
      emit(BottomNavArchivedTask());
    }
  }

  void bottomSheetClosed() {
    _isBottomSheetOpened = false;
    emit(BottomSheetClosed());
  }

  void bottomSheetOpened() {
    _isBottomSheetOpened = true;
    emit(BottomSheetOpened());
  }

  Future insertToTasksTable(Task task) async {
    return await tasksRepository.insertTask(task).then((value) {
      emit(TaskSavedSuccessfully());
      getTasksFromDB();
    }).catchError((onError) => emit(ErrorOnSaveTask()));
  }

  Future getTasksFromDB() async {
    return await tasksRepository.getTasks().then((value) {
      allTasks = value;
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];

      for (var element in allTasks) {
        if (element.status == 'new') newTasks.add(element);
        if (element.status == 'done') doneTasks.add(element);
        if (element.status == 'archived') archivedTasks.add(element);
        print(element.toString());
      }

      emit(DataRetrievedFromDB());
    }).catchError((onError) {
      emit(ErrorOnGetTasks());
      print('error when get data from db ${onError.toString()}');
    });
  }

  Future updateTask(Task task) async {
    return await tasksRepository.updateTask(task).then((value) {
      emit(TaskUpdatedSuccessfully());
      getTasksFromDB();
    }).catchError((onError) => emit(ErrorOnUpdateTask()));
  }

  Future deleteTask(int id) async {
    return await tasksRepository.deleteTask(id).then((value) {
      emit(TaskDeletedSuccessfully());
      getTasksFromDB();
    }).catchError((onError) => emit(ErrorOnDeleteTask()));
  }
}
