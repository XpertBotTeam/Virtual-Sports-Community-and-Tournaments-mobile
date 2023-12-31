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
  // variable to cache the ImageProvider value of Base64 images to avoid converting base64 to imageProvider
  // every time the widget re-renders.
  Map<String, ImageProvider> imagesCache = {};

  // refresh squad
  refreshSquad() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  // returning pitch image based on team theme color
  AssetImage getImageFromThemeColor() {
    if (widget.themeColor == 'purple') {
      return const AssetImage("lib/assets/pitches/purple.webp");
    }
    if (widget.themeColor == 'blue') {
      return const AssetImage("lib/assets/pitches/blue.png");
    }
    if (widget.themeColor == 'red') {
      return const AssetImage("lib/assets/pitches/red.png");
    } else {
      return const AssetImage("lib/assets/pitches/green.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    // variables to place players on the pitch responsively
    var width = MediaQuery.of(context).size.width;
    var fivePercent = MediaQuery.of(context).size.width * 0.05;
    var boxWidth = 60;
    var boxHeight = boxWidth + 5 + boxWidth / 4 + 3 + boxWidth / 4;
    var imageAspectRatio = 763 / 964; // from image properties

    // we calculate startX, startY (0), endX, endY for accurate and responsive design
    final startX = fivePercent + 10; // 10px until field start
    final endX = width - fivePercent - 10; //

    // calculating endY:
    var imageWidth = endX - startX;
    var imageHeight = imageWidth / imageAspectRatio;
    final endY = imageHeight;

    return Stack(children: [
      Opacity(
        opacity: 0.5,
        child: Container(
          height: 450,
          margin: EdgeInsets.symmetric(horizontal: fivePercent),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: getImageFromThemeColor(), fit: BoxFit.fitWidth)),
        ),
      ),

      // goalkeeper
      PlayerBox(
          player: widget.players[0],
          initialBoxX: startX + imageWidth / 2 - boxWidth / 2,
          initialBoxY: 0,
          refreshSquad: refreshSquad),
      // defenders
      PlayerBox(
          player: widget.players[1],
          initialBoxX: startX,
          initialBoxY: boxHeight * 1.2,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[2],
          initialBoxX: startX + 1.1 * boxWidth,
          initialBoxY: boxHeight / 2,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[3],
          initialBoxX: endX - 1.1 * 2 * boxWidth,
          initialBoxY: boxHeight / 2,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[4],
          initialBoxX: endX - boxWidth,
          initialBoxY: boxHeight * 1.2,
          refreshSquad: refreshSquad),
      // midfielders
      PlayerBox(
          player: widget.players[5],
          initialBoxX: startX + imageWidth / 2 - boxWidth / 2,
          initialBoxY: 1.5 * boxHeight,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[6],
          initialBoxX: startX + 1.1 * boxWidth,
          initialBoxY: 2.2 * boxHeight,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[7],
          initialBoxX: endX - 1.1 * 2 * boxWidth,
          initialBoxY: 2.2 * boxHeight,
          refreshSquad: refreshSquad),
      // attackers
      PlayerBox(
          player: widget.players[8],
          initialBoxX: startX,
          initialBoxY: endY - boxHeight * 1.5,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[9],
          initialBoxX: endX - boxWidth,
          initialBoxY: endY - boxHeight * 1.5,
          refreshSquad: refreshSquad),
      PlayerBox(
          player: widget.players[10],
          initialBoxX: startX + imageWidth / 2 - boxWidth / 2,
          initialBoxY: endY - boxHeight,
          refreshSquad: refreshSquad),
    ]);
  }
}
