// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/business_logic/cubit/home_cubit.dart';
import 'package:to_do/common/components/list_view_components.dart';
import 'package:to_do/data/model/task_model.dart';

class ArchiveTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return TasksListViewBuilder(
          cubit: cubit,
          tasks: cubit.archivedTasks,
        );
      },
    );
  }
}
