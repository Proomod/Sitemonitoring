import 'dart:math';

import 'package:site_monitoring/cementTests/compressiveStrength/utilities/db.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/utilities/dbMigrator.dart';

List<CompressiveStrength> cubesList = [];

class CompressiveStrength {
  int cubeId;
  int cubeNo;
  int cubeDay;
  double cubeWeight;
  double cubeLoad;

  static final table = "CompressiveStrength";
  static final columnId = '_cube_id';
  static final columnCubeDay = "Cube_Day";
  static final columnCubeNo = "Cube_No";
  static final columnCubeWeight = "Cube_wt";
  static final columnCubeLoad = "Cube_load";

  static final dbHelper = DatabaseHelper.instance;

  CompressiveStrength(
      {this.cubeId = 1,
      this.cubeNo,
      this.cubeDay,
      this.cubeWeight,
      this.cubeLoad});

  static final columns = [
    'cubeId',
    "cubeNo",
    'cubeDay',
    "cubeWeight",
    'cubeLoad'
  ];
  static addCubesToDataBase() {
    // int maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
    // DbMigrator.migrations.addAll({
    //   maxMigratedDbVersion + 1: '''
    //         CREATE TABLE [IF NOT EXISTS] $table(
    //           $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    //           $columnCubeDay INTEGER NOT NULL,
    //           $columnCubeNo INTEGER NOT NULL,
    //           $columnCubeWeight REAL NOT NULL,
    //           $columnCubeLoad REAL NOT NULL
    //         )'''
    // });
  }

  static Future<List<CompressiveStrength>> getCubes() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows(table);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (i) => CompressiveStrength(
          cubeId: maps[i]['_cube_id'],
          cubeDay: maps[i]['Cube_Day'],
          cubeNo: maps[i]['Cube_No'],
          cubeLoad: maps[i]['Cube_wt'],
          cubeWeight: maps[i]['Cube_load'],
        ),
      );
    }
    return [];

    // return cubesList;
  }

  static addCubeData(CompressiveStrength cube) async {
    Map<String, dynamic> cubeData = {
      // DatabaseHelper.columnId: cube.cubeId,
      columnCubeDay: cube.cubeDay,
      columnCubeNo: cube.cubeNo,
      columnCubeWeight: cube.cubeWeight,
      columnCubeLoad: cube.cubeLoad,
    };
    int id = await dbHelper.insert(table, cubeData);
    print('inserted row $id');
  }

  static Future<int> deleteCubeData(CompressiveStrength cube) async {
    print("cube id ${cube.cubeId}");
    return await dbHelper.delete(table, columnId, cube.cubeId);
  }

  static Future<int> getCubeCount() async {
    return await dbHelper.queryRowCount(table);
  }
}
