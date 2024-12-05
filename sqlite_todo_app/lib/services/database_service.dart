import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseName = 'paranie.db';
  static const _databaseVersion = 1;

  // Table and column names
  static const tasksTableName = 'tasks';
  static const _tasksIdColumnName = 'id';
  static const _tasksNameColumnName = 'name';
  static const _tasksIsDoneColumnName = 'isDone';

  // Singleton pattern
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _database;

  DatabaseService._constructor();

  Future<Database> getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _databaseName);
    
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tasksTableName(
            $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_tasksNameColumnName TEXT NOT NULL,
            $_tasksIsDoneColumnName INTEGER NOT NULL
          )
        ''');
      },
    );
  }


  // Add a task to the database
  void addTask(String taskName) async {
    final db = await getDatabase();
    await db.insert(
      tasksTableName,
      {
        _tasksNameColumnName: taskName,
        _tasksIsDoneColumnName: 0,
      },
    );
  }
}