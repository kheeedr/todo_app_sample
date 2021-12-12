import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/presentation/archive_tasks/archive_tasks_screen.dart';
import 'package:to_do/presentation/done_taskes/done_taskes_screen.dart';
import 'package:to_do/presentation/new_tasks/new_tasks_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  void bottomNavStateChanged(int navIndex) =>
      emit(BottomNavStateChanged(navIndex));

  void isBottomSheetOpened(bool isOpen) =>
      emit(BottomSheetStateChanged(isOpen));
}
