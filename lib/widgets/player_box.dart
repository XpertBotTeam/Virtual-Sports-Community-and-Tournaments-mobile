import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/dialogs/editplayer_bottom_sheet.dart';
import 'package:sqflite/sqflite.dart';


class PlayerBox extends StatefulWidget {
  
  // class data fields
  final PlayerCard player;
  final double initialBoxX ;
  final double initialBoxY ;
  final Function refreshSquad;
  final Map<String, ImageProvider> imagesCache;

  const PlayerBox({
    super.key, 
    required this.player,
    required this.initialBoxX, 
    required this.initialBoxY, 
    required this.refreshSquad,
    required this.imagesCache
  });

  @override
  State<PlayerBox> createState() => _PlayerBoxState();
}


class _PlayerBoxState extends State<PlayerBox> {

  // data fields
  double boxX = 0;
  double boxY = 0;
  final double boxWidth = 60; 
  late final Database db;
  
  // initializing data fields
  @override
  void initState() {
    super.initState();
    boxX = widget.initialBoxX;
    boxY = widget.initialBoxY;
    loadDb();
  }

  // creating a db instance to perform crud operations
  loadDb() async {
    db = await SQLHelper.db();
  }

  // open edit player dialog
  openEditPlayerDialog() async {
    showDialog(
      context: context,
      builder: (context) => EditPlayerBottomSheet(widget.player, db: db, refreshSquad: widget.refreshSquad)
    );
  }

  // caching player image if the image was not cached preciouslt, and returning CircleAvatar widget to display on screen
  CircleAvatar cachePlayerImage() {
    PlayerCard player = widget.player;
    widget.imagesCache[player.starterImage!] = MemoryImage(fromBase64ToByte(player.starterImage!));
    return CircleAvatar(
        backgroundImage: widget.imagesCache[player.starterImage!] ,
        radius: boxWidth / 2,
     );
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
        onTap: () => openEditPlayerDialog(),
        child: SizedBox(
          width: boxWidth,
          child: Column(
            children: [
              if (widget.player.starterImage != null && widget.imagesCache[widget.player.starterImage] != null) 
                CircleAvatar(
                  backgroundImage:  widget.imagesCache[widget.player.starterImage],
                  radius: boxWidth / 2,
                ),
              if (widget.player.starterImage != null && widget.imagesCache[widget.player.starterImage] == null)                 
                cachePlayerImage(),

              if (widget.player.starterImage == null) 
              CircleAvatar(
                backgroundImage: const AssetImage("lib/assets/others/no pp.png"),
                radius: boxWidth / 2,
              ),
              
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: boxWidth / 4,
                color: lightGray,
                child: Center(
                  child: Text(
                     widget.player.starterNo != null? 
                        "${widget.player.starterNo!}. ${widget.player.starterName}" :
                        widget.player.starterName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10
                    ),
                  )
                ),
              ) ,
              const SizedBox(height: 3) ,

              // back up name box should only appear if there a is a back up
              if (widget.player.backupName != null && widget.player.backupName != "") 
                Container(
                  width: double.infinity,
                  height: boxWidth / 4,
                  color: darkGray,
                  child: Center(
                    child: Text(
                      widget.player.backupNo != null? 
                        "${widget.player.backupNo!}. ${widget.player.backupName!}" :
                        widget.player.backupName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11
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