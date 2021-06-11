import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/utilities/dbMigrator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "CementTests.db";
  // static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
    return await openDatabase(
      path,
      version: maxMigratedDbVersion,
      onOpen: (db) {},
      onCreate: _onCreate,
      onUpgrade: (Database db, oldVersion, newVersion) async {
        var curDbVersion = await getCurrentDbVersion(db);
        var upgradedScripts = new Map.fromIterable(
            DbMigrator.migrations.keys.where((k) => k > curDbVersion),
            key: (k) => k,
            value: (k) => DbMigrator.migrations[k]);
        if (upgradedScripts.length == 0) return;
        upgradedScripts.keys.toList()
          ..sort()
          ..forEach((k) async {
            var script = upgradedScripts[k]!;
            await db.execute(script);
          });
        _upgradeDbVersion(db, maxMigratedDbVersion);
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    DbMigrator.migrations.keys.toList()
      ..sort()
      ..forEach((k) async {
        var script = DbMigrator.migrations[k]!;
        await db.execute(script);
      });
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await (instance.database as FutureOr<Database>);
    return await db.insert(table, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await (instance.database as FutureOr<Database>);
    return await db.query(table);
  }

  Future<int?> queryRowCount(String table) async {
    Database db = await (instance.database as FutureOr<Database>);
    return Sqflite.firstIntValue(
        await db.rawQuery('''SELECT COUNT(*) FROM $table'''));
  }

  Future<int> update(
      String table, String columnId, Map<String, dynamic> row) async {
    Database db = await (instance.database as FutureOr<Database>);
    int? id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String columnId, int? id) async {
    Database db = await (instance.database as FutureOr<Database>);
    return await db.delete(table, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> getCurrentDbVersion(db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]['user_version'].toString();
    return int.parse(version);
  }

  void _upgradeDbVersion(Database db, int version) async {
    await db.rawQuery("PRAGMA user_version=$version;");
  }
}
