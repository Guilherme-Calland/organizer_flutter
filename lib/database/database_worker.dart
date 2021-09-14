import 'package:organizer/database/database_brain.dart' as dbBrain;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseWorker{
  Database? _database;
  String dbType;
  DatabaseWorker(this.dbType);

  Future get database async {
    return _database ?? await _initializeDatabase();
  }

  Future _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    String entityDBPath = join(databasePath, '$dbType.db');
    Database db = await openDatabase(
      entityDBPath, version: 1, onCreate: _onCreate
    );
    return db;
  }

  Future<Map<String, dynamic>?> get(int inID) async{
    Database db = await database;
    List query = await db.query(
      '$dbType', where: 'id = ?', whereArgs: [inID]
    );
    Map<String, dynamic>? result = query.first;
    return result;
  }

  Future _onCreate(Database db, int version) async {
    String? sql;
    switch(this.dbType){
      case 'notes': sql = dbBrain.notesSql; break;
      case 'appointments' : sql = dbBrain.appointmentsSql; break;
      case 'tasks' : sql = dbBrain.tasksSql; break;
    }
    if(sql != null){
      await db.execute(sql);
    }
  }

  Future create(Map<String, dynamic> inData) async {
    Database db = await database;
    int result;
    result = await db.insert(dbType, inData);
    return result;
  }

  Future read() async{
    Database db = await database;
    String sql = 'SELECT * FROM ${dbType} ORDER BY id';
    List data = await db.rawQuery(sql);
    return data;
  }

  Future update(Map<String, dynamic> data) async{
    Database db = await database;
    int result = await db.update(
      dbType,
      data,
      where: 'id = ?',
      whereArgs: [ data['id'] ]
    );
    return result;
  }

  Future delete(int inID) async {
    Database db = await database;
    int result = await db.delete(
      dbType, where: 'id = ?', whereArgs: [inID]
    );
    return result;
  }
}