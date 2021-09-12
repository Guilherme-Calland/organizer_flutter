import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseWorker{
  Database? _database;

  DatabaseWorker();

  Future get database async {
    return _database ?? await _initializeDatabase();
  }

  Future _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    String entityDBPath = join(databasePath, 'notes.db');
    Database db = await openDatabase(
      entityDBPath, version: 1, onCreate: _onCreate
    );
    return db;
  }

  Future _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE notes('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'content TEXT, '
        'color TEXT'
        ')';
    await db.execute(sql);
  }

  Future create(Map<String, dynamic> inData) async {
    Database db = await database;
    int result;
    result = await db.insert('notes', inData);
    return result;
  }
}