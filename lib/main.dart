import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/presentation/home_layout.dart';

import 'business_logic/cubit/home_cubit.dart';
import 'business_logic/cubit/new/new_tasks_cubit.dart';
import 'data/local/tasks_db.dart';
import 'data/repo/tasks_repository.dart';
import 'my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
            create: (context) => NewTasksCubit(TasksRepository(TasksDB()))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeLayout(),
      ),
    );
  }
}
