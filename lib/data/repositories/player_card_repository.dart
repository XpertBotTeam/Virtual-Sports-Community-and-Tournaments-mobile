import 'package:sqflite/sqflite.dart' as sql;
import '../models/player_card.dart';

class PlayerCardRepository {

  // class data fields
  final sql.Database database;

  // class constructor
  PlayerCardRepository(this.database);

  // insertOne
  Future<int> insertPlayerCard(PlayerCard playerCard) async {
    return await database.insert('player_card', playerCard.toMap());
  }

  // insert 11 players for a team
  Future<void> insertPlayersForTeam(int teamId) async {
    for (int i = 0 ; i < 11 ; i++) {
      await database.insert('player_card', PlayerCard(teamId: teamId).toMap());
    }
  }

  // retrieving players by team id
  Future<List<PlayerCard>> getPlayersByTeamId(int teamId) async {
    final List<Map<String, dynamic>> maps = await database.query('player_card', where: 'team_id = ?', whereArgs: [teamId]);
    return List.generate(maps.length, (i) {
      return PlayerCard.fromMap(maps[i]);
    });
  }

  // retrieving one player by id
  Future<PlayerCard> getPlayerById(int cardId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'player_card',
      where: 'card_id = ?',
      whereArgs: [cardId],
    );
    if (maps.isNotEmpty) {
      return PlayerCard.fromMap(maps.first);
    } else {
      throw Exception('Player not found');
    }
  } 

  // update
  Future<int> updatePlayerCard(PlayerCard playerCard) async {
    return await database.update(
      'player_card',
      playerCard.toMap(),
      where: 'card_id = ?',
      whereArgs: [playerCard.cardId],
    );
  }

 // delete
 Future<int> deletePlayerCard(int cardId) async {
    return await database.delete(
      'player_card',
      where: 'card_id = ?',
      whereArgs: [cardId],
    );
  }
}
