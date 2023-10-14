import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/folder.dart';

class FolderRepository {
  
  // class field
  sql.Database database;
  
  // constructor
  FolderRepository(this.database);

  // insert folder
  Future<int> insertFolder(Folder folder) async {
    return await database.insert('folders', folder.toMap());
  }

  // retrieve folders
  Future<List<Folder>> getFolders() async {
    final List<Map<String, dynamic>> folderMaps = await database.query('folders');
    final List<Folder> folders = [];

    // mapping folders map to folders object
    for(final folderMap in folderMaps) {
      Folder folder = Folder.fromMap(folderMap);
      TeamRepository teamRepository = TeamRepository(database);
      final List<Team> teams = await teamRepository.getTeamsByFolderId(folder.folderId!);
      folder.teams = teams;
      folders.add(folder);
    }
    return folders;
  }

  // update folders
  Future<int> updateFolder(Folder folder) async {
    return await database.update(
      'folders',
      folder.toMap(),
      where: 'folder_id = ?',
      whereArgs: [folder.folderId],
    );
  }
  
  // delete folders
  Future<int> deleteFolder(int folderId) async {
    return await database.delete(
      'folders',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
  }


}