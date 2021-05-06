class DbMigrator {
  static final Map<int, String> migrations = {
    1: '''
      CREATE TABLE IF NOT EXISTS CementSetting(
        SETTINGTIME_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Setting_Type VARCHAR NOT NULL,
        DateTime INTEGER NOT NULL
         
      );
      ''',
    3: '''
            CREATE TABLE IF NOT EXISTS CompressiveStrength(
              _cube_id INTEGER PRIMARY KEY AUTOINCREMENT,
              Cube_Day INTEGER NOT NULL,
              Cube_No INTEGER NOT NULL,
              Cube_wt REAL NOT NULL,
              Cube_load REAL NOT NULL
            );'''
  };

//every table creation should happen here
}
