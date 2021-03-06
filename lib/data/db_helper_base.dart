import 'dart:async';
import 'dart:io' as io;

import 'package:flutter_test_dev/model/base_model.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperBase {
  static Database _db;

  //----------------------------- Base Helper ---------------------------------
  static const String title = 'title';
  static const String description = 'description';
  static const String date = 'date';
  static const String maker = 'maker';
  static const String TABLEBASE = 'BaseHelper';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "baseHelper.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLEBASE (id INTEGER PRIMARY KEY, "
        "$title TEXT, $description TEXT, $date TEXT, $maker TEXT)");
  }

  Future<int> saveBaseDB(BaseModel baseHelper) async {
    var dbClient = await db;
    int res = await dbClient.insert(TABLEBASE, baseHelper.toJson());

    getBaseDB();

    return res;
  }

  Future<int> updateBaseDB(BaseModel baseHelper) async {
    var dbClient = await db;

    int baseUpdate = await dbClient.rawUpdate(
      'UPDATE $TABLEBASE SET $title = ?, $description = ?, $date = ? '
      'WHERE id = ${baseHelper.id}',
      [
        baseHelper.title,
        baseHelper.description,
        baseHelper.date,
      ],
    );

    getBaseDB();

    return baseUpdate;
  }

  Future<dynamic> getBaseDB() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query(
        TABLEBASE,
        columns: [
          'id',
          title,
          description,
          date,
          maker,
        ],
        where: 'maker = ?',
        whereArgs: [userMaker]);

    List<dynamic> dataDB = [];

    if (maps != null) {
      for (int i = 0; i < maps.length; i++) {
        dataDB.add(maps[i]);
      }
    }

    streamController.sink.add(dataDB);

    return dataDB;
  }

  Future deleteBaseDB(int id) async {
    var dbClient = await db;
    int res =
        await dbClient.delete(TABLEBASE, where: 'id = ?', whereArgs: [id]);

    getBaseDB();

    return res;
  }

  Future closeBaseDB() async {
    var dbClient = await db;
    dbClient.close();
  }
}
