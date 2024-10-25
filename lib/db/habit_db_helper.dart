import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/models/habit.dart';

class HabitDbHelper {
  static Database? _dbh;
  static const int _version = 1;
  static const String _tableName = "habits";

  static Future<void> initDb() async {
    if (_dbh != null) {
      debugPrint("not null db");
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + "habit.db";
        debugPrint("in database path");

        _dbh = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
              debugPrint("creating a new one");
              return db.execute(
                'CREATE TABLE $_tableName ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    ' name STRING,'
                    ' description TEXT,'
                    ' startDate INTEGER,'
                    ' remind INTEGER,'
                    ' isCompleted INTEGER)',
              );
            });

        List<Map<String, dynamic>> columns = await _dbh!.rawQuery('PRAGMA table_info(habits)');

        // Print the columns and their details
        for (var column in columns) {
          print('Column: ${column['name']}, Type: ${column['type']}, Not Null: ${column['notnull']}, Default Value: ${column['dflt_value']}');
        }

        print("DATA Base Created");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insertHabit(Habit? habit) async {
    print("insert function called");
    return await _dbh!.insert(_tableName, habit!.toJson());
  }

  static Future<int> deleteHabit(Habit habit) async {
    print("delete function called");
    return await _dbh!.delete(_tableName, where: 'id = ?', whereArgs: [habit.id]);
  }

  static Future<int> deleteAllHabit() async {
    print("deleteAll function called");
    return await _dbh!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _dbh!.query(_tableName);
  }

  static Future<int> updateHabit(int id) async {
    print("update function called");
    return await _dbh!.rawUpdate('''
    UPDATE habits
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
