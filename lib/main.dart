import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/archived_tasks/cubit/archived_tasks_cubit.dart';
import 'package:to_do/ui/create_tasks/cubit/crud_cubit.dart';
import 'package:to_do/ui/done_tasks/cubit/done_tasks_cubit.dart';
import 'package:to_do/ui/home/home_layout.dart';
import 'package:to_do/ui/new_tasks/cubit/new_tasks_cubit.dart';
import 'data/local/tasks_db.dart';
import 'data/repo/tasks_repository.dart';
import 'my_bloc_observer.dart';
import 'ui/home/cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await TasksDB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final tasksRepo = TasksRepository(TasksDB());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CrudCubit(tasksRepo),
        ),
        BlocProvider(
          create: (context) =>
              NewTasksCubit(tasksRepo, BlocProvider.of<CrudCubit>(context)),
        ),
        BlocProvider(
          create: (context) => ArchivedTasksCubit(
            tasksRepo,
            BlocProvider.of<CrudCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) =>
              DoneTasksCubit(tasksRepo, BlocProvider.of<CrudCubit>(context)),
        ),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: HomeLayout(),
      ),
    );
  }
}
