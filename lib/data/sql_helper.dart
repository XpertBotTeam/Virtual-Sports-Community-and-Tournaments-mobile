import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class SQLHelper { 

  static const String DB_NAME = "lineupmaster.db";

  // returning a db instance
  static Future<sql.Database> db() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);

    return sql.openDatabase(
      path,
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await database.execute("ALTER TABLE player_card ADD COLUMN backup_no INT");
        }
      },
    ); 
  }

  // creating tables
  static Future<void> createTables(sql.Database database) async {
    // folders table
    await database.execute("""
      CREATE TABLE folders (
        folder_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        folder_name VARCHAR(55),
        folder_logo VARCHAR(400)
      )
    """);

    // teams table
    await database.execute("""
      CREATE TABLE teams (
        team_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        team_logo VARCHAR(500),
        team_subtitle VARCHAR(45),
        manager_name VARCHAR(45),
        theme_color VARCHAR(45),
        manager_image VARCHAR(500),
        team_name VARCHAR(80),
        folder_id INTEGER,
        FOREIGN KEY (folder_id) REFERENCES folders(folder_id)
      ) 
    """);

    await database.execute("""
      CREATE TABLE player_card (
        card_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        starter_image VARCHAR(500),
        starter_name VARCHAR(45),
        starter_no INT,
        backup_name VARCHAR(45),
        backup_no INT,
        team_id INTEGER NOT NULL,
        FOREIGN KEY (team_id) REFERENCES teams(team_id)
      )
    """);
  }
}