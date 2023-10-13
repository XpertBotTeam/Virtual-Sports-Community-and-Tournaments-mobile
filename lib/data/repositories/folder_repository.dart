import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/folder.dart';

class FolderRepository {
  
  sql.Database database;
  
  FolderRepository(this.database);

  Future<int> insertFolder(Folder folder) async {
    return await database.insert('folders', folder.toMap());
  }

  Future<List<Folder>> getFolders() async {
    final List<Map<String, dynamic>> folderMaps = await database.query('folders');
    final List<Folder> folders = [];

    for(final folderMap in folderMaps) {
      Folder folder = Folder.fromMap(folderMap);
      TeamRepository teamRepository = TeamRepository(database);
      final List<Team> teams = await teamRepository.getTeamsByFolderId(folder.folderId!);
      folder.teams = teams;
      folders.add(folder);
    }
    return folders;
  }


  Future<int> updateFolder(Folder folder) async {
    return await database.update(
      'folders',
      folder.toMap(),
      where: 'folder_id = ?',
      whereArgs: [folder.folderId],
    );
  }
  

  Future<int> deleteFolder(int folderId) async {
    return await database.delete(
      'folders',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
  }


}