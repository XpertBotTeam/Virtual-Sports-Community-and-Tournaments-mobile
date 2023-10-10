class Team {
  int? teamId;
  String teamLogo;
  String teamSubtitle;
  String managerName;
  String themeColor;
  String? managerImage;
  String teamName;
  int? folderId;
 
  Team({
    this.teamId,
    required this.teamLogo,
    required this.teamSubtitle,
    this.managerName = "Manager Name",
    this.themeColor = "green",  
    this.managerImage,
    required this.teamName,
    this.folderId,
  });

  // Convert a Team object to a map for database operations.
  Map<String, dynamic> toMap() {
    return {
      'team_id': teamId,
      'team_logo': teamLogo,
      'team_subtitle': teamSubtitle,
      'manager_name': managerName,
      'theme_color': themeColor,
      'manager_image': managerImage,
      'team_name': teamName,
      'folder_id': folderId,
    };
  }

  // Create a Team object from a map.
  static Team fromMap(Map<String, dynamic> map) {
    return Team(
      teamId: map['team_id'],
      teamLogo: map['team_logo'],
      teamSubtitle: map['team_subtitle'],
      managerName: map['manager_name'],
      themeColor: map['theme_color'],
      managerImage: map['manager_image'],
      teamName: map['team_name'],
      folderId: map['folder_id'],
    );
  }

  @override
  String toString() {
    return """
        Team { 
          teamId: $teamId,
          teamSubtitle: $teamSubtitle,
          managerName: $managerName,  
          themeColor: $themeColor, 
          managerImage: $managerImage,
          teamName: $teamName, 
          folderId: $folderId, 
          teamLogo: $teamLogo, 
          }
        """;
  }
}
