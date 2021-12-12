import 'package:sqflite/sqflite.dart';
import 'package:to_do/common/constants.dart';
import 'package:to_do/data/model/task_model.dart';

class TasksDB {
  Future<Database> openDB() async {
    return await openDatabase(
      databaseFileName,
      version: 1,
      onCreate: (database, version) async {
        try {
          await database.execute('''CREATE TABLE $tasksTableName
               (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                title TEXT, date TEXT, time TEXT, status TEXT)
                ''');
          print('table created');
        } catch (e) {
          print('error on creating DB $e');
        }
      },
      onOpen: (database) => print('database opened'),
    );
  }

  Future insertToTasksTable({required Task task}) async {
    return await openDB().then(
      (db) => db
          .insert(tasksTableName, task.toMap())
          .then((value) => print('$value inserted successfully'))
          .catchError(
            (error) =>
                print('error when  Inserting New Record ${error.toString()}'),
          ),
    );
  }

  Future<List<Map<String, dynamic>>> getAllTasksFromDB() async {
    return await openDB().then((db) => db.query('tasks')).catchError(
          (error) => print(
            'error when get data from db ${error.toString()}',
          ),
        );
  }

  Future<List<Map<String, dynamic>>> getTasksFromDatabaseByStatus(
    String status,
  ) async {
    return await openDB()
        .then((db) => db.query(
              'tasks',
              where: 'status=?',
              whereArgs: [status],
            ))
        .catchError(
          (error) => print(
            'error when get data from db ${error.toString()}',
          ),
        );
  }

  Future updateTask({required Task task}) async {
    return await openDB()
        .then((dp) => dp.update(
              tasksTableName,
              task.toMap(),
              where: 'id = ?',
              whereArgs: [task.id],
            ))
        .catchError(
            (error) => print('error when update db ${error.toString()}'));
  }

  Future deleteTask({required int id}) async {
    return await openDB()
        .then((dp) => dp.delete(
              tasksTableName,
              where: 'id = ?',
              whereArgs: [id],
            ))
        .catchError((error) =>
            print('error when delete item from db ${error.toString()}'));
  }
}

// database
//     .execute(
//     'CREATE TABLE $tasksTableName (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, date TEXT, time TEXT, status TEXT)')
// .then((value) => print('table created'))
// .catchError((error) => print('error on creating DB $error'));
