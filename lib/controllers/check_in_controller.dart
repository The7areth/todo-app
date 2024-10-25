import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/habit_check_in.dart';

class HabitCheckInController {
  static final HabitCheckInController _instance = HabitCheckInController._internal();

  factory HabitCheckInController() {
    return _instance;
  }

  HabitCheckInController._internal();

  Database? _database;

  // Initialize the database (Singleton pattern)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Open or create the database
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'habit_checkins.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE habit_checkins (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            habitId INTEGER,
            date TEXT,
            checkedIn INTEGER
          )
        ''');
      },
    );
  }

  // Save a new check-in
  Future<int> saveCheckIn(HabitCheckIn habitCheckIn) async {
    final db = await database;
    return await db.insert('habit_checkins', habitCheckIn.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieve all check-ins for a specific habit
  Future<List<HabitCheckIn>> getAllCheckIns(int habitId) async {
    final db = await database;
    final result = await db.query(
      'habit_checkins',
      where: 'habitId = ?',
      whereArgs: [habitId],
      orderBy: 'date ASC',
    );
    return result.map((checkIn) => HabitCheckIn.fromMap(checkIn)).toList();
  }

  // Retrieve a check-in status for a specific habit and date
  Future<HabitCheckIn?> getCheckIn(int habitId, DateTime date) async {
    final db = await database;
    final result = await db.query(
      'habit_checkins',
      where: 'habitId = ? AND date = ?',
      whereArgs: [habitId, date.toIso8601String()],
    );

    if (result.isNotEmpty) {
      return HabitCheckIn.fromMap(result.first);
    }
    return null; // No check-in found for this date
  }

  // Get all check-ins for a specific habit in a month
  Future<List<HabitCheckIn>> getCheckInsForMonth(int habitId, int year, int month) async {
    final db = await database;

    // Get the first and last day of the month
    final startDate = DateTime(year, month, 1).toIso8601String();
    final endDate = DateTime(year, month + 1, 0).toIso8601String();

    final result = await db.query(
      'habit_checkins',
      where: 'habitId = ? AND date BETWEEN ? AND ?',
      whereArgs: [habitId, startDate, endDate],
      orderBy: 'date ASC',
    );

    return result.map((checkIn) => HabitCheckIn.fromMap(checkIn)).toList();
  }
}
