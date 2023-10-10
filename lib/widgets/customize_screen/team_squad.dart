import 'package:flutter/material.dart';
import 'package:lineupmaster/widgets/player_box.dart';

class TeamSquad extends StatefulWidget {
  const TeamSquad({super.key});

  @override
  State<TeamSquad> createState() => _TeamSquadState();
}


class _TeamSquadState extends State<TeamSquad> {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Opacity(
          opacity: 0.5,
          child: Container(
            height: 450,    
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/pitches/green.png"),
              )
            ),        
          ),
        ),
        PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15 , initialBoxX: 0, initialBoxY: 0),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // PlayerBox(boxWidth: MediaQuery.of(context).size.width * 0.15),
        // const PlayerBox(initialBoxX: 95, initialBoxY: 45)
      ] 
    );
  }
}