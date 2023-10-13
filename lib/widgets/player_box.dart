import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/utils/colors.dart';


class PlayerBox extends StatefulWidget {
  
  final PlayerCard player;
  final double initialBoxX ;
  final double initialBoxY ;
  final double boxWidth;

  const PlayerBox({
    super.key, 
    required this.player,
    required this.initialBoxX, 
    required this.initialBoxY, 
    required this.boxWidth
  });

  @override
  State<PlayerBox> createState() => _PlayerBoxState();
}


class _PlayerBoxState extends State<PlayerBox> {

  double boxX = 0;
  double boxY = 0;
  double boxWidth = 0;

  @override
  void initState() {
    super.initState();
    boxX = widget.initialBoxX;
    boxY = widget.initialBoxY;
    boxWidth = widget.boxWidth;
  }

  @override
  Widget build(BuildContext context) {

    return Positioned(
      left: boxX,
      top: boxY,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (boxX + details.delta.dx >= 0) {
            boxX += details.delta.dx;
          }
          if (boxY + details.delta.dy >= 0) {
            boxY += details.delta.dy;              
          }  
          setState(() {});
        },
        child: SizedBox(
          width: boxWidth,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: const NetworkImage("https://www.thesun.co.uk/wp-content/uploads/2023/05/crop-22459323.jpg?w=620"),
                radius: boxWidth / 2,
              ),
              Container(
                width: double.infinity,
                height: boxWidth / 5,
                color: lightGray,
                child: const Center(
                  child: Text(
                    "Ter Stegen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  )
                ),
              ) ,
              const SizedBox(height: 3) ,
              Container(
                width: double.infinity,
                height: boxWidth / 5,
                color: darkGray,
                child: const Center(
                  child: Text(
                    "Pena",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  )
                ),
              ) ,
            ],
          ),
        ),
      ),      
    );
  }
}