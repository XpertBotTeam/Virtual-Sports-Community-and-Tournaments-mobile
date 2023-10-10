import 'package:sqflite/sqflite.dart' as sql;
import '../models/player_card.dart';

class PlayerCardRepository {
  final sql.Database database;

  PlayerCardRepository(this.database);

  Future<int> insertPlayerCard(PlayerCard playerCard) async {
    return await database.insert('player_card', playerCard.toMap());
  }

  Future<List<PlayerCard>> getPlayersByTeamId(int teamId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'player_card',
      where: 'team_id = ?',
      whereArgs: [teamId],
    );
    return List.generate(maps.length, (i) {
      return PlayerCard.fromMap(maps[i]);
    });
  }


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

  Future<int> updatePlayerCard(PlayerCard playerCard) async {
    return await database.update(
      'player_card',
      playerCard.toMap(),
      where: 'card_id = ?',
      whereArgs: [playerCard.cardId],
    );
  }

  Future<int> deletePlayerCard(int cardId) async {
    return await database.delete(
      'player_card',
      where: 'card_id = ?',
      whereArgs: [cardId],
    );
  }
}
