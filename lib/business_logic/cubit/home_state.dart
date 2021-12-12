part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

// TODO (max)::  the bloc must handle single state changes ONLY ONE
class HomeInitial extends HomeState {}

class BottomNavStateChanged extends HomeState {
  late final int _navIndex;
  late String _tittle;
  late Widget _screen;

  int get navIndex => _navIndex;
  String get tittle => _tittle;
  Widget get screen => _screen;

  BottomNavStateChanged(this._navIndex) {
    _tittle = _titles[_navIndex];
    _screen = _screens[_navIndex];
  }

  final List<Widget> _screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  final List<String> _titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
}

class BottomSheetStateChanged extends HomeState {
  final bool _isBottomSheetOpened;

  bool get isBottomSheetOpened => _isBottomSheetOpened;

  BottomSheetStateChanged(this._isBottomSheetOpened);
}
