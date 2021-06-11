import 'package:site_monitoring/cementTests/compressiveStrength/utilities/db.dart';

class CementSetting {
//time is added in hours and minute here
//
  final int? cementSettingId;
  String? settingType;
  int? settingDateTime;

  static final table = 'CementSetting';
  static final columnCementSettingId = "SETTINGTIME_ID";
  static final columnSettingType = "Setting_Type";
  static final columnDateTime = "DateTime";

  CementSetting({
    this.cementSettingId = 1,
    this.settingType,
    this.settingDateTime,
  });

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
                settingType: maps[i]['$columnSettingType'],
                settingDateTime: maps[i]['$columnDateTime'],
              ));
    }
    return [];
  }

  static addData(CementSetting time) async {
    Map<String, dynamic> data = {
      columnSettingType: time.settingType,
      columnDateTime: time.settingDateTime,
    };
    int id = await dbHelper.insert(table, data);
    print('inserted row $id');
  }

  static Future<int> deleteCubeData(CementSetting time) async {
    print("settingtime id ${time.cementSettingId}");
    return await dbHelper.delete(
        table, columnCementSettingId, time.cementSettingId);
  }

  static Future<int?> getCubeCount() async {
    return await dbHelper.queryRowCount(table);
  }
}
