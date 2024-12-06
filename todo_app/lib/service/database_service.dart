import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database ? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _taskTableName="tasks";
  final String _taskIdColumnName="id";
  final String _taskContentColumnName="id";
  final String _taskDescriptionColumnName="id";
  final String _taskStatusColumnName="id";

  DatabaseService._constructor();

  Future<Database> get database async {
    if(_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }


  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) => {
        db.execute('''
        CREATE TABLE $_taskTableName(
          $_taskIdColumnName INTEGER PRIMARY KEY,
          $_taskContentColumnName TEXT NOT NULL,
          $_taskStatusColumnName INT NOT NULL,
          $_taskDescriptionColumnName TEXT,
        )
        ''')
      },
    );
    return database;
  }
}