import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do/ui/create_tasks/create_tasks_screen.dart';
import 'package:to_do/ui/done_tasks/done_tasks_screen.dart';
import 'package:to_do/ui/home/cubit/home_cubit.dart';
import 'package:to_do/ui/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatelessWidget {
  final titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  final screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        late bool isInitial;
        isInitial = state is! BottomNavStateChanged;
        final homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: isInitial ? Text(titles[0]) : Text(titles[state.navIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateNewTaskPage()),
              );
            },
            child: const Icon(Icons.mode),
          ),
          body: isInitial ? screens[0] : screens[state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => homeCubit.bottomNavIndexChanged(index),
            currentIndex: isInitial ? 0 : state.navIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                label: 'Tasks',
                icon: Icon(Icons.menu),
              ),
              BottomNavigationBarItem(
                label: 'Done',
                icon: Icon(Icons.check_circle_outline),
              ),
              BottomNavigationBarItem(
                label: 'Archived',
                icon: Icon(Icons.archive_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
