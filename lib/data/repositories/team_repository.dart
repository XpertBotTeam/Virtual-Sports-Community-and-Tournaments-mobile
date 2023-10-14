import 'package:lineupmaster/data/repositories/player_card_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/team.dart';

class TeamRepository {
  
  // class data fields
  sql.Database database;

  // constructor (for dependency injection)
  TeamRepository(this.database);

  // insert
  Future<int> insertTeam(Team team) async {
    int teamId = await database.insert('teams', team.toMap());
    PlayerCardRepository playerCardRepository = PlayerCardRepository(database);
    await playerCardRepository.insertPlayersForTeam(teamId);
    return teamId;
  }

  // retrieve all 
  Future<List<Team>> getTeams() async {
    final List<Map<String, dynamic>> maps = await database.query('teams');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  // retrieve teams outside folders
  Future<List<Team>> getIndependentTeams() async {
    final List<Map<String, dynamic>> maps = await database.query('teams', where: 'folder_id IS NULL');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  // retrieve team by id
  Future<Team?> getTeamById(int teamId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'teams',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
    if (maps.isNotEmpty) {
      return Team.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // retrieve teams by id
  Future<List<Team>> getTeamsByFolderId(int folderId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'teams',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  // retrieve last team
  Future<Team?> getLastTeam() async {
    final teamMap = await database.query('teams', orderBy: 'team_id DESC', limit: 1);
    if (teamMap.isNotEmpty) {
      return Team.fromMap(teamMap.first);
    }
    return null;
  }

  // update team
  Future<int> updateTeam(Team team) async {
    return await database.update(
      'teams',
      team.toMap(),
      where: 'team_id = ?',
      whereArgs: [team.teamId],
    );
  }
  
  // delete team
  Future<int> deleteTeam(int teamId) async {
    return await database.delete(
      'teams',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
  }


}