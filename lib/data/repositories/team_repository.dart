import 'package:lineupmaster/data/sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/team.dart';

class TeamRepository {
  
  static late sql.Database database;

  TeamRepository();

  static Future<int> insertTeam(Team team) async {
    database = await SQLHelper.db();
    return await database.insert('teams', team.toMap());
  }

  static Future<List<Team>> getTeams() async {
    database = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await database.query('teams');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  static Future<List<Team>> getIndependentTeams() async {
    database = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await database.query('teams', where: 'folder_id IS NULL');
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }


  static Future<Team> getTeamById(int teamId) async {
    database = await SQLHelper.db();
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


  static Future<List<Team>> getTeamsByFolderId(int folderId) async {
    database = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await database.query(
      'teams',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
    return List.generate(maps.length, (i) {
      return Team.fromMap(maps[i]);
    });
  }

  static Future<Team?> getLastTeam() async {
    database = await SQLHelper.db();
    final teamMap = await database.query('teams', orderBy: 'team_id DESC', limit: 1);
    if (teamMap.isNotEmpty) {
      return Team.fromMap(teamMap.first);
    }
    return null;
  }


  static Future<int> updateTeam(Team team) async {
    database = await SQLHelper.db();
    return await database.update(
      'teams',
      team.toMap(),
      where: 'team_id = ?',
      whereArgs: [team.teamId],
    );
  }
  
  static Future<int> deleteTeam(int teamId) async {
    database = await SQLHelper.db();
    return await database.delete(
      'teams',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
  }



}