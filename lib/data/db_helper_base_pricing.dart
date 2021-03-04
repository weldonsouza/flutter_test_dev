import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperBase {
  static Database _db;

  //----------------------------- Base Pricing ---------------------------------
  static const String dateSchedule = 'dateSchedule';
  static const String usrSchedule = 'usrSchedule';
  static const String loginSchedule = 'loginSchedule';
  static const String codeBar = 'codeBar';
  static const String codeProduct = 'codeProduct';
  static const String descrProduct = 'descrProduct';
  static const String codeDepartment = 'codeDepartment';
  static const String descrDepartment = 'descrDepartment';
  static const String providers = 'providers';
  static const String branch = 'branch';
  static const String priceIn = 'priceIn';
  static const String pricePer = 'pricePer';
  static const String collectBase = 'collectBase';
  static const String TABLEBASE = 'BasePricing';
  //----------------------------------------------------------------------------
  static const String idCollect = 'idCollect';
  static const String idCompany = 'idCompany';
  static const String company = 'company';
  static const String dateBase = 'dateBase';
  static const String status = 'status';
  static const String usrCollect = 'usrCollect';
  static const String usrLoginCollect = 'usrLoginCollect';
  static const String publicPlace = 'publicPlace';
  static const String city = 'city';
  static const String state = 'state';
  static const String urlLogo = 'urlLogo';
  static const String cnpj = 'cnpj';
  static const String price = 'price';
  static const String urlPhoto = 'urlPhoto';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String blobImages = 'blobImages';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "basePricing.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLEBASE (id INTEGER PRIMARY KEY, "
        "$dateSchedule TEXT, $usrSchedule TEXT, $loginSchedule TEXT, "
        "$codeBar TEXT, $codeProduct TEXT, $descrProduct TEXT, $codeDepartment TEXT, "
        "$descrDepartment TEXT, $providers TEXT, $branch TEXT, $priceIn TEXT, "
        "$pricePer TEXT, $idCollect TEXT, $idCompany TEXT, $company TEXT, "
        "$dateBase TEXT, $status TEXT, $usrCollect TEXT, $usrLoginCollect TEXT, "
        "$publicPlace TEXT, $city TEXT, $state TEXT, $urlLogo BLOB, $cnpj TEXT, "
        "$price TEXT, $urlPhoto BLOB, $latitude TEXT, $longitude TEXT, "
        "$blobImages BLOB)");
  }

  Future<int> saveBaseDB(basePricing) async {
    var dbClient = await db;
    int res = await dbClient.insert(TABLEBASE, basePricing.toJson());
    //int res1 = await dbClient.insert(TABLEPRICING, basePricing.coletas[0].toJson());

    return res;
  }

  Future<int> updateBaseDB(collect) async {
    var dbClient = await db;

    int collectUpdate = await dbClient.rawUpdate(
          'UPDATE $TABLEBASE SET $usrCollect = ?, $usrLoginCollect = ?, $price = ?,'
          ' $longitude = ?, $latitude = ?, $urlPhoto = ?, $dateBase = ?, '
          '$blobImages = ?, $status = ? WHERE $idCollect = ${collect.idCollect}',
        [
          collect.usrCollect,
          collect.usrLoginCollect,
          collect.price,
          collect.longitude,
          collect.latitude,
          collect.urlPhoto,
          collect.dateBase,
          collect.blobImages,
          collect.status,
        ],
    );

    return collectUpdate;
  }

  Future<dynamic> getBaseDB({view}) async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query(
      TABLEBASE,
      //columns: [codProduto, preco],
      //where: "$codProduto = ?",
      orderBy: '$price DESC',
    );

    List<dynamic> collect = [];

    if (maps != null) {



      return collect;
    } else {
      return null;
    }
  }

  //Pesquisa a coleta seleciona
  Future<dynamic> getBasePreviewDB({idCollectSearch}) async {
    var dbClient = await db;
    List<dynamic> collect = [];

    List<Map> maps = await dbClient.query(
        TABLEBASE,
        where: "$idCollect IN ($idCollectSearch)",
        //whereArgs: [idCollectSearch],
        orderBy: '$price DESC'
    );

    if (maps != null) {
      for (int i = 0; i < maps.length; i++) {
        collect.add(maps[i]);
      }

      getBaseDB();

      return collect;
    } else {
      return null;
    }
  }

  Future<void> deleteBaseDB({int idCollectDelete, view = false}) async {
    var dbClient = await db;

    int res = await dbClient.delete(
        TABLEBASE,
        where: '$idCollect = ?',
        whereArgs: [idCollectDelete]
    );

    //dbBasePricing.getBaseDB(view: view);

    //return await dbClient.delete('$TABLEBASE');
    return res;
  }

  Future closeBaseDB() async {
    var dbClient = await db;
    dbClient.close();
  }
}
