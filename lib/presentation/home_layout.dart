// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/business_logic/cubit/home_cubit.dart';
import 'package:to_do/common/components/custom_text_form_field.dart';
import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(TasksRepository(TasksDB()))..getTasksFromDB(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.navIndex],
              ),
            ),
            body: cubit.screens[cubit.navIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetOpened) {
                  if (formKey.currentState!.validate()) {
                    Task newTask = Task(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);

                    cubit.insertToTasksTable(newTask).then((_) {
                      Navigator.pop(context);
                      cubit.bottomSheetClosed();
                    }).catchError((error) => print(error.toString()));
                  }
                } else {
                  cubit.bottomSheetOpened();
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => bottomSheet(context),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        backgroundColor: Colors.white,
                      )
                      .closed
                      .then((value) {
                    cubit.bottomSheetClosed();
                    dateController.clear();
                    timeController.text = '';
                    titleController.text = '';
                  });
                }
              },
              child: cubit.isBottomSheetOpened
                  ? Icon(Icons.save, color: Colors.white)
                  : Icon(Icons.edit, color: Colors.white),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.navIndex = index;
              },
              currentIndex: cubit.navIndex,
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
      ),
    );
  }

  Form bottomSheet(context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 30.0,
          left: 20,
          right: 20,
          top: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              controller: titleController,
              label: "Title",
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Title can't be empty";
                }
              },
              prefixIcon: Icon(Icons.title),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: dateController,
              label: "Date",
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Date can't be empty";
                }
              },
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse('2025-05-03'),
                ).then((value) =>
                    dateController.text = DateFormat.yMMMd().format(value!));
              },
              prefixIcon: Icon(Icons.calendar_today),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: timeController,
              label: "Time",
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Title can't be empty";
                }
              },
              readOnly: true,
              prefixIcon: Icon(Icons.watch_later),
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) => timeController.text =
                        value!.format(context).toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
