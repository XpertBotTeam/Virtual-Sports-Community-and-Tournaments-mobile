import 'package:lineupmaster/data/repositories/player_card_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/team.dart';

class TeamRepository {
  
  sql.Database database;

  TeamRepository(this.database);

  Future<int> insertTeam(Team team) async {
    int teamId = await database.insert('teams', team.toMap());
    PlayerCardRepository playerCardRepository = PlayerCardRepository(database);
    await playerCardRepository.insertPlayersForTeam(teamId);
    return teamId;
  }


  Future<List<Team>> getTeams() async {
    final List<Map<String, dynamic>> maps = await database.query('teams');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  Future<List<Team>> getIndependentTeams() async {
    final List<Map<String, dynamic>> maps = await database.query('teams', where: 'folder_id IS NULL');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }


  Future<Team> getTeamById(int teamId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'teams',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
    if (maps.isNotEmpty) {
      return Team.fromMap(maps.first);
    } else {
      throw Exception('Team not found');    }
  }


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

  Future<Team?> getLastTeam() async {
    final teamMap = await database.query('teams', orderBy: 'team_id DESC', limit: 1);
    if (teamMap.isNotEmpty) {
      return Team.fromMap(teamMap.first);
    }
    return null;
  }


  Future<int> updateTeam(Team team) async {
    return await database.update(
      'teams',
      team.toMap(),
      where: 'team_id = ?',
      whereArgs: [team.teamId],
    );
  }
  
  Future<int> deleteTeam(int teamId) async {
    return await database.delete(
      'teams',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
  }



}