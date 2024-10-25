import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/projects.dart';

class ProjectController {
  static final ProjectController _instance = ProjectController._internal();

  factory ProjectController() {
    return _instance;
  }

  ProjectController._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'projects.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            startDate TEXT,
            endDate TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  // Create a new project
  Future<int> createProject(Project project) async {
    final db = await database;
    return await db.insert('projects', project.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieve all projects
  Future<List<Project>> getAllProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> json = await db.query('projects');
    return List.generate(json.length, (i) {
      return Project.fromJson(json[i]);
    });
  }

  // Update an existing project
  Future<int> updateProject(Project project) async {
    final db = await database;
    return await db.update(
      'projects',
      project.toJson(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  // Delete a project
  Future<void> deleteProject(int id) async {
    final db = await database;
    await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
