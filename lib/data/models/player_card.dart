class PlayerCard {

  // table fields
  int? cardId;
  String? starterImage;
  String starterName;
  int? starterNo;
  String? backupName;
  int? backupNo;
  int teamId;

  // constructor
  PlayerCard({
    required this.teamId,
    this.cardId,
    this.starterImage,
    this.starterName = "Player Name",
    this.starterNo,
    this.backupName,
    this.backupNo,
  });

  // Convert a PlayerCard object to a map for database operations.
  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'starter_image': starterImage,
      'starter_name': starterName,
      'starter_no': starterNo,
      'backup_name': backupName,
      'backup_no': backupNo,
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
      backupNo: map['backup_no'],
      teamId: map['team_id'],
    );
  }

  // toString to print a PLayerCard object
  @override
  String toString() {
    return """PlayerCard { 
      cardId: $cardId, 
      starterImage: $starterImage, 
      starterName: $starterName, 
      starterNo: $starterNo, 
      backupName: $backupName, 
      backupNo: $backupNo, 
      teamId: $teamId 
    }
    """;
  }

}
