import 'package:flutter/material.dart';
import 'package:to_do/data/model/task_model.dart';

class CustomTasksListItem extends StatelessWidget {
  final Task task;
  final DismissDirectionCallback onDismissed;
  final VoidCallback onDoneIconPressed;
  final VoidCallback onArchivedIconPressed;

  const CustomTasksListItem({
    required this.task,
    required this.onDismissed,
    required this.onDoneIconPressed,
    required this.onArchivedIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      key: Key(task.id.toString()),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 40,
              child: Text(
                task.time,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text(
                    task.date,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (task.status != 'done')
              IconButton(
                iconSize: 35,
                onPressed: onDoneIconPressed,
                icon: const Icon(
                  Icons.check_box_outlined,
                  color: Colors.deepPurple,
                ),
              ),
            if (task.status != 'archived')
              IconButton(
                iconSize: 35,
                onPressed: onArchivedIconPressed,
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomListViewSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
    );
  }
}
