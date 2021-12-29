import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:to_do/common/components/custom_button.dart';
import 'package:to_do/common/components/custom_text_form_field.dart';
import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/data/repo/tasks_repository.dart';
import 'package:to_do/ui/new_tasks/cubit/new_tasks_cubit.dart';
import 'cubit/crud_cubit.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  State<CreateNewTaskPage> createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  final tasksRepository = TasksRepository(TasksDB());

  final cubit = CrudCubit(TasksRepository(TasksDB()));

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final dateController = TextEditingController();

  final timeController = TextEditingController();

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    final navigator = Navigator.of(context);
    final newTaskCubit = BlocProvider.of<NewTasksCubit>(context);
    try {
      if (isValid) {
        await BlocProvider.of<CrudCubit>(context).insertTask(
          Task(
            title: titleController.text,
            date: dateController.text,
            time: timeController.text,
          ),
        );
        newTaskCubit.refreshNewTasks();
        navigator.pop();
      } else {
        throw 'Invalid input';
      }
    } catch (error) {
      edgeAlert(
        context,
        title: error.toString(),
        gravity: Gravity.bottom,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextFormField(
                controller: titleController,
                label: "Title",
                validator:
                    qValidator([const IsRequired("Title can't be empty")]),
                prefixIcon: const Icon(Icons.title),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: dateController,
                label: "Date",
                validator:
                    qValidator([const IsRequired("Date can't be empty")]),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse('2025-05-03'),
                  );
                  if (date == null) return;

                  dateController.text = DateFormat.yMMMd().format(date);
                },
                prefixIcon: const Icon(Icons.calendar_today),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: timeController,
                label: "Time",
                validator:
                    qValidator([const IsRequired("Title can't be empty")]),
                readOnly: true,
                prefixIcon: const Icon(Icons.watch_later),
                onTap: () async {
                  final tod = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (tod == null) return;
                  if (!mounted) return;
                  timeController.text = tod.format(context);
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onPressed: submit,
                    text: 'save',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
