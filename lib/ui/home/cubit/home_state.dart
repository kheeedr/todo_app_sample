part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class BottomNavStateChanged extends HomeState {
  final int navIndex;

  BottomNavStateChanged(this.navIndex);
}
