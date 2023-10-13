import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/widgets/player_box.dart';

class TeamSquad extends StatefulWidget {
  
  final List<PlayerCard> players;
  const TeamSquad({super.key, required this.players});

  @override
  State<TeamSquad> createState() => _TeamSquadState();
}


class _TeamSquadState extends State<TeamSquad> {

  
  @override
  Widget build(BuildContext context) {
    print("players: ${widget.players.length}");
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
        
        PlayerBox(player: widget.players[0], boxWidth: MediaQuery.of(context).size.width * 0.15 , initialBoxX: 0, initialBoxY: 0),
      
      ] 
    );
  }
}