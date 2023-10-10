class PlayerCard {

  int? cardId;
  String? starterImage;
  String starterName;
  int starterNo;
  String? backupName;
  int teamId;

  PlayerCard({
    this.cardId,
    this.starterImage,
    required this.starterName,
    required this.starterNo,
    required this.backupName,
    required this.teamId,
  });

  // Convert a PlayerCard object to a map for database operations.
  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'starter_image': starterImage,
      'starter_name': starterName,
      'starter_no': starterNo,
      'backup_name': backupName,
      'team_id': teamId,
    };
  }

  // Create a PlayerCard object from a map.
  static PlayerCard fromMap(Map<String, dynamic> map) {
    return PlayerCard(
      cardId: map['card_id'],
      starterImage: map['starter_image'],
      starterName: map['starter_name'],
      starterNo: map['starter_no'],
      backupName: map['backup_name'],
      teamId: map['team_id'],
    );
  }

  @override
  String toString() {
    return 'PlayerCard { cardId: $cardId, starterImage: $starterImage, starterName: $starterName, starterNo: $starterNo, backupName: $backupName, teamId: $teamId }';
  }

}
