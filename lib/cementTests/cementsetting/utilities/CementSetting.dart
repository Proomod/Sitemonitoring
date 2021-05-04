import 'dart:math';

import 'package:site_monitoring/cementTests/compressiveStrength/utilities/db.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/utilities/dbMigrator.dart';
import 'package:sqflite/sqflite.dart';

class CementSetting {
//time is added in hours and minute here
//
  final int cementSettingId;
  final Duration t1wateraddedtime;
  final Duration t2initialsetting;
  final Duration t3finalsetting;
  static final table = 'CementSetting';
  static final columnWaterAddedTime = "waterAddedTime";
  static final columnCementSettingId = "ID";
  static final columninitialSetting = "Initial_setting";
  static final columnfinalsetting = "FinalSetting";

  CementSetting(
      {this.cementSettingId = 1,
      this.t1wateraddedtime,
      this.t2initialsetting,
      this.t3finalsetting});

  static final dbHelper = DatabaseHelper.instance;

  // static addToDatabase() async {
  //   Database db = await dbHelper.database;
  //   int maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
  //   print('something interesting $maxMigratedDbVersion');
  //   int currentDBversion = await dbHelper.getCurrentDbVersion(db);
  //   print('what is this $currentDBversion');

  //   DbMigrator.migrations.addAll({
  //     maxMigratedDbVersion + 1: '''
  //     CREATE TABLE [IF NOT EXISTS] $table(
  //       SETTINGTIME_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  //       $columnWaterAddedTime INTEGER NOT NULL,
  //       $columninitialSetting INTEGER NOT NULL,
  //       $columnfinalsetting INTEGER NOT NULL
  //     )
  //     '''
  //   });

  //   await dbHelper.database;
  // }

  static Future<List<CementSetting>> getData() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows(table);
    if (maps.isNotEmpty) {
      return List.generate(
          maps.length,
          (i) => CementSetting(
              cementSettingId: maps[i]['$columnCementSettingId'],
              t1wateraddedtime: maps[i]['$columnWaterAddedTime'],
              t2initialsetting: maps[i]['$columninitialSetting'],
              t3finalsetting: maps[i]['$columnfinalsetting']));
    }
    return [];
  }

  static addData(CementSetting time) async {
    Map<String, dynamic> data = {
      columnWaterAddedTime: time.t1wateraddedtime,
      columninitialSetting: time.t2initialsetting,
      columnfinalsetting: time.t3finalsetting
    };
    int id = await dbHelper.insert(table, data);
    print('inserted row $id');
  }

  static Future<int> deleteCubeData(CementSetting time) async {
    print("settingtime id ${time.cementSettingId}");
    return await dbHelper.delete(
        table, columnCementSettingId, time.cementSettingId);
  }

  static Future<int> getCubeCount() async {
    return await dbHelper.queryRowCount(table);
  }
}
