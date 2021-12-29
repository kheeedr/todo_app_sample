import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:to_do/common/constants.dart';
import 'package:to_do/data/model/task_model.dart';

class TasksDB {
  static Database? _instance;

  static Database get instance {
    if (_instance == null) throw 'should call `TasksDB.init()` first  ⛔';
    return _instance!;
  }

  static Future<void> init() async {
    try {
      await openDatabase(
        databaseFileName,
        version: 1,
        onCreate: (database, version) async {
          try {
            await database.execute(
              '''
              CREATE TABLE $tasksTableName
              (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              title TEXT, date TEXT, time TEXT, status TEXT)
              ''',
            );
            log('table created');
          } catch (e) {
            log('error on creating DB $e');
          }
        },
        onOpen: (database) {
          _instance = database;
          log('database opened');
        },
      );
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
    }
  }

  Future<void> insertToTasksTable({required Task task}) async {
    try {
      final taskId = await instance.insert(tasksTableName, task.toMap());
      log('$taskId inserted successfully');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> getAllTasksFromDB() {
    try {
      return instance.query('tasks');
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> getTasksFromDatabaseByStatus(
    String status,
  ) async {
    try {
      return instance.query(
        'tasks',
        where: 'status=?',
        whereArgs: [status],
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateTask({required Task task}) async {
    try {
      await instance.update(
        tasksTableName,
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (error) {
      rethrow;
    }
  }

  Future deleteTask({required int id}) async {
    try {
      await instance.delete(
        tasksTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (error) {
      log('error when delete item from db ${error.toString()}');
    }
  }
}
