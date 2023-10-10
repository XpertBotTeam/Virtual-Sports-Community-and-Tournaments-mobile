import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/widgets/customize_screen/team_info.dart';
import 'package:lineupmaster/widgets/customize_screen/team_squad.dart';
import 'package:lineupmaster/utils/colors.dart';

// ignore: must_be_immutable
class CustomizeScreen extends StatefulWidget {

  Team? team;

  CustomizeScreen({super.key, this.team}); 

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}


class _CustomizeScreenState extends State<CustomizeScreen> {

  bool noTeamFound = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  fetchData() async {
    // if no team is passed, we retrieve last team from db
    widget.team = await TeamRepository.getLastTeam();
    // if team is still null => no team stored in db
    if (widget.team == null) {
      noTeamFound = true;
      return;
    }
    print("Team is ${widget.team}");
    // retrieving team players, manager...    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // LAYER 1
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/sco/thumb/4/47/FC_Barcelona_%28crest%29.svg/2020px-FC_Barcelona_%28crest%29.svg.png",
                width: MediaQuery.of(context).size.width * 0.6
              ),
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
            children: const [
              TeamInfo(),
              TeamSquad()
            ],
          )
        ],  
      ),
    );
  }
}