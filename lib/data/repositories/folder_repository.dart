import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/folder.dart';

class FolderRepository {
  
  static late sql.Database database;
  
  static Future<int> insertFolder(Folder folder) async {
    database = await SQLHelper.db();
    return await database.insert('folders', folder.toMap());
  }

  static Future<List<Folder>> getFolders() async {
    database = await SQLHelper.db();

    final List<Map<String, dynamic>> folderMaps = await database.query('folders');
    final List<Folder> folders = [];

    for(final folderMap in folderMaps) {
      Folder folder = Folder.fromMap(folderMap);
      final List<Team> teams = await TeamRepository.getTeamsByFolderId(folder.folderId!);
      folder.teams = teams;
      folders.add(folder);
    }
    return folders;
  }


  static Future<int> updateFolder(Folder folder) async {
    database = await SQLHelper.db();
    return await database.update(
      'folders',
      folder.toMap(),
      where: 'folder_id = ?',
      whereArgs: [folder.folderId],
    );
  }
  

  static Future<int> deleteFolder(int folderId) async {
    database = await SQLHelper.db();
    return await database.delete(
      'folders',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
  }


}