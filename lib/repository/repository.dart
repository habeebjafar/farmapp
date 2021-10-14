import 'package:farmapp/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late  DbConnection _connection;

  Repository() {
    _connection = DbConnection();
  }

   late Database _database;
  Future<Database> get database async {
    //if(_database != null) return _database;

    _database = await _connection.setDatabase();
    return _database;
  }

  saveItem(table, data) async {
    var con = await database;
    return con.insert(table, data);
  }

  getAllItem(table) async {
    var conn = await database;
    return conn.query(table);

  }

  getItemById(table, itemId) async {
    var con = await database;
    return con.rawQuery("SELECT * FROM $table WHERE id = $itemId");
  }

  updateItem(table, data) async {
    var con = await database;
    return con.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteItemById(table, itemId) async {
    var con = await database;
    return con.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }
}
