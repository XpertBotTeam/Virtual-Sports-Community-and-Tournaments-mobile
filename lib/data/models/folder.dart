import 'package:lineupmaster/data/models/team.dart';

class Folder {
  // table fields
  int? folderId;
  String folderName;
  String folderLogo;
  List<Team>? teams;

  // constructor
  Folder(
      {this.folderId,
      required this.folderName,
      required this.folderLogo,
      this.teams});

  // Convert a Folder object to a map for database operations.
  Map<String, dynamic> toMap() {
    return {
      'folder_id': folderId,
      'folder_name': folderName,
      'folder_logo': folderLogo,
    };
  }

  // Create a Folder object from a map to use in Flutter app.
  static Folder fromMap(Map<String, dynamic> map) {
    return Folder(
        folderId: map['folder_id'],
        folderName: map['folder_name'],
        folderLogo: map['folder_logo'],
        teams: null);
  }

  // toString to print the folder
  @override
  String toString() {
    String? teamsString = teams?.map((team) => team.toString()).join('\n');
    return """Folder { 
      folderId: $folderId, 
      folderName: $folderName, 
      teams: [
        $teamsString
      ]
      folderLogo: $folderLogo,
    }    
    """;
  }
}
