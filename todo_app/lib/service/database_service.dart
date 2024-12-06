import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _taskTableName = "tasks";
  final String _taskIdColumnName = "id";
  final String _taskContentColumnName = "content";
  final String _taskDescriptionColumnName = "description";
  final String _taskStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "todo_app_db.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE $_taskTableName(
        $_taskIdColumnName INTEGER PRIMARY KEY,
        $_taskContentColumnName TEXT NOT NULL,
        $_taskStatusColumnName INT NOT NULL,
        $_taskDescriptionColumnName TEXT
      )
      ''');
        print("Table created successfully"); // Debugging message
      },
    );
    return database;
  }

  Future<void> addTask(String content, {String? description}) async {
    final db = await database;

    int id = await db.insert(_taskTableName, {
      _taskContentColumnName: content,
      _taskStatusColumnName: 0,
      _taskDescriptionColumnName: description,
    });

    print("Task added with ID: $id"); // Debug log
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_taskTableName);
    return data
        .map((e) => Task(
              id: e[_taskIdColumnName] as int,
              status: e[_taskStatusColumnName] as int,
              content: e[_taskContentColumnName] as String,
            ))
        .toList();
  }
}
