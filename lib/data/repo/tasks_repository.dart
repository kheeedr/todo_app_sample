import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';

class TasksRepository {
  TasksDB tasksDB;

  TasksRepository(this.tasksDB);

  Future insertTask(Task task) async {
    return tasksDB.insertToTasksTable(task: task);
  }

  Future<List<Task>> getTasks() async {
    final tasksList = await tasksDB.getAllTasksFromDB();
    return tasksList.map((e) => Task.fromMap(e)).toList();
  }

  Future<List<Task>> getTasksFromDatabaseByStatus(String status) async {
    final tasksList = await tasksDB.getTasksFromDatabaseByStatus(status);
    return tasksList.map((e) => Task.fromMap(e)).toList();
  }

  Future updateTask(Task task) async {
    return tasksDB.updateTask(task: task);
  }

  Future deleteTask(int id) async {
    return tasksDB.deleteTask(id: id);
  }
}
