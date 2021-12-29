import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  //final CreateTaskCubit newTasksCubit;

  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  void bottomNavIndexChanged(int navIndex) =>
      emit(BottomNavStateChanged(navIndex));
}
