import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/player_card_repository.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/customizescreen/team_info.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/customizescreen/team_squad.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class CustomizeScreen extends StatefulWidget {

  const CustomizeScreen({super.key}); 

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}


class _CustomizeScreenState extends State<CustomizeScreen> {

  List<PlayerCard>? players;
  bool noTeamFound = false;
  late Database db;
  Team? selectedTeam;

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  fetchData() async {
    // opening db connection
    db = await SQLHelper.db();
    // creating repositories
    TeamRepository teamRepository = TeamRepository(db);
    PlayerCardRepository playerCardRepository = PlayerCardRepository(db);

    // retrieving selected team from state
    final selectedTeamModel = Provider.of<SelectedTeamModel>(context, listen: false);
    selectedTeam = selectedTeamModel.selectedTeam;
    
    // if no team is selected previously => app is opening
    if (selectedTeam == null) {
      selectedTeam = await teamRepository.getLastTeam();

      // if selected team still equal to null => no team stored in the db
      if (selectedTeam == null) {
        noTeamFound = true;
        return;
      }
      else {
        selectedTeamModel.updateSelectedTeam(selectedTeam);      
      }
    } 
    // retrieving team players
    players = await playerCardRepository.getPlayersByTeamId(selectedTeam!.teamId!);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    // to refresh the page whenever selected team updates
    Provider.of<SelectedTeamModel>(context);

    // no team created yet
    if (noTeamFound) {
      return const Center(child: Text("No teams yet."));
    }
    // data not loaded yet
    if (players == null || selectedTeam == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Stack(
        children: [
          // LAYER 1
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.memory(fromBase64ToByte(selectedTeam!.teamLogo), width: MediaQuery.of(context).size.width * 0.6),
            ),      
          ),
    
          // LAYER 2
          Opacity(
            opacity: 0.9,
            child: Container(
              foregroundDecoration: BoxDecoration(
                color: selectedTeam!.themeColor == 'green'? 
                          greenColor :
                          selectedTeam!.themeColor == 'blue'?
                            blueColor :
                              selectedTeam!.themeColor == 'red'?
                                redColor : purpleColor
              ),
            )
          ),
    
          // LAYER 3
          ListView(
            children: [
              TeamInfo(team: selectedTeam!, players: players!, db: db),
              TeamSquad(players: players!, themeColor: selectedTeam!.themeColor)
            ],
          )
        ],  
      ),
    );
  }
}