import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/widgets/player_box.dart';

class TeamSquad extends StatefulWidget {
  
  final List<PlayerCard> players;
  final String themeColor;
  const TeamSquad({super.key, required this.players, required this.themeColor});

  @override
  State<TeamSquad> createState() => _TeamSquadState();
}

class _TeamSquadState extends State<TeamSquad> {

  refreshSquad() {
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Opacity(
          opacity: 0.5,
          child: Container(
            height: 450,    
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.themeColor == 'green'?
                    const AssetImage("lib/assets/pitches/green.png") : 
                      widget.themeColor == 'purple'?
                        const AssetImage("lib/assets/pitches/purple.webp") :
                        widget.themeColor == 'blue'?
                          const AssetImage("lib/assets/pitches/blue.png") :
                          const AssetImage("lib/assets/pitches/red.png")
              )
            ),        
          ),
        ),
        
        PlayerBox(player: widget.players[0], initialBoxX: 0, initialBoxY: 0, refreshSquad: refreshSquad),
      
      ] 
    );
  }
}