import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';

// making selectedTeam a global state accessible from everywhere using Provider
class SelectedTeamModel extends ChangeNotifier {

  Team? _team;

  Team? get selectedTeam => _team;
  
  void updateSelectedTeam(newTeam) {
    _team = newTeam;
    notifyListeners();
  }

}