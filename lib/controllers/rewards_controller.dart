import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/rewards.dart';

class RewardController {
  static final RewardController _instance = RewardController._internal();

  factory RewardController() {
    return _instance;
  }

  RewardController._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'rewards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE rewards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT, 
            title TEXT,
            description TEXT,
            points INTEGER
          )
        ''');
      },
    );
  }

  // Get top 10 users by points
  Future<List<Map<String, dynamic>>> getTopUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT username, SUM(points) as total_points
      FROM rewards
      GROUP BY username
      ORDER BY total_points DESC
      LIMIT 10
    ''');

    return result;
  }
}
