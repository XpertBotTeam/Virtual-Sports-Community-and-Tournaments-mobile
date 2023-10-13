import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/player_card_repository.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/customize_screen/team_info.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/customize_screen/team_squad.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class CustomizeScreen extends StatefulWidget {

  Team? team;

  CustomizeScreen({super.key, this.team}); 

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}


class _CustomizeScreenState extends State<CustomizeScreen> {

  List<PlayerCard>? players;
  bool noTeamFound = false;
  late Database db;

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }


  fetchData() async {
    // opening db connection
    db = await SQLHelper.db();
    // creating repositories
    TeamRepository teamRepository = TeamRepository(db);
    PlayerCardRepository playerCardRepository = PlayerCardRepository(db);

    // if no team is passed, we retrieve last team from db
    widget.team = await teamRepository.getLastTeam();
    // if team is still null => no team stored in db
    if (widget.team == null) {
      noTeamFound = true;
      return;
    }
    print("Team is ${widget.team}");

    // retrieving team players
    players = await playerCardRepository.getPlayersByTeamId(widget.team!.teamId!);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    // no team created yet
    if (noTeamFound) {
      return const Center(child: Text("Please create and select a team"));
    }
    // data not loaded yet
    if (players == null || widget.team == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Stack(
        children: [
          // LAYER 1
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.memory(fromBase64ToByte(widget.team!.teamLogo), width: MediaQuery.of(context).size.width * 0.6),
            ),      
          ),
    
          // LAYER 2
          Opacity(
            opacity: 0.9,
            child: Container(
              foregroundDecoration: BoxDecoration(
                color: greenColor
              ),
            )
          ),
    
          // LAYER 3
          ListView(
            children: [
              TeamInfo(team: widget.team!, players: players!, db: db),
              TeamSquad(players: players!)
            ],
          )
        ],  
      ),
    );
  }
}