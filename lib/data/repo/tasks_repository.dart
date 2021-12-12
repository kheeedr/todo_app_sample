import 'package:to_do/data/local/tasks_db.dart';
import 'package:to_do/data/model/task_model.dart';

class TasksRepository {
  TasksDB tasksDB;

  TasksRepository(this.tasksDB);

  Future insertTask(Task task) async {
    return await tasksDB.insertToTasksTable(task: task);
  }

  Future<List<Task>> getTasks() async {
    return Task.mapToTasks(await tasksDB.getAllTasksFromDB());
  }

  Future<List<Task>> getTasksFromDatabaseByStatus(String status) async {
    return Task.mapToTasks(await tasksDB.getTasksFromDatabaseByStatus(status));
  }

  Future updateTask(Task task) async {
    return await tasksDB.updateTask(task: task);
  }

  Future deleteTask(int id) async {
    return await tasksDB.deleteTask(id: id);
  }
}
