import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class TeamInfo extends StatefulWidget {

  final Team team;
  final List<PlayerCard> players;
  final Database db;

  const TeamInfo({super.key, required this.team, required this.players, required this.db});

  @override
  State<TeamInfo> createState() => _TeamInfoState();
}


class _TeamInfoState extends State<TeamInfo> {

  @override
  Widget build(BuildContext context) {

    final TextEditingController teamNameController = TextEditingController(text: widget.team.teamName.toUpperCase());
    final TextEditingController teamManagerNameController = TextEditingController(text: widget.team.managerName);
    final TextEditingController teamSubtitleController= TextEditingController(text: widget.team.teamSubtitle ?? "Subtitle");
    final TeamRepository teamRepository = TeamRepository(widget.db);

    updateTeamName(newName) async {
      widget.team.teamName = newName;
      await teamRepository.updateTeam(widget.team);      
    }

    updateTeamManagerName(newName) async {
      widget.team.managerName = newName;
      await teamRepository.updateTeam(widget.team);
    }

    updateSubtitle(newSubtitle) async {
      widget.team.teamSubtitle = newSubtitle;
      await teamRepository.updateTeam(widget.team);
    }

    pickManagerImage(context) async {
      String? imageB64 = await pickGalleryImage(context);
      if (imageB64 != null) {
        widget.team.managerImage = imageB64;
        await teamRepository.updateTeam(widget.team);
        setState(() {});
      }
    }

    pickTeamImage(context) async {
      String? imageB64 = await pickGalleryImage(context);
      if (imageB64 != null) {
        widget.team.teamLogo = imageB64;
        await teamRepository.updateTeam(widget.team);
        setState(() {});
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () async => await pickTeamImage(context),
                        child: Image.memory(fromBase64ToByte(widget.team.teamLogo), width: 45, height: 45, fit: BoxFit.cover)
                      )
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: teamNameController, 
                          onChanged: (value) async => await updateTeamName(value), 
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w900
                          ), 
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              Positioned(
                right: 20,
                top: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          TextField(
            controller: teamSubtitleController, 
            textAlign: TextAlign.center,
            onChanged: (value) async => await updateSubtitle(value), 
            style: const TextStyle(
                color: whiteColor ,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ), 
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero
            ),
          ) ,

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: Text(
                  "Manager: ",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ) ,
              const SizedBox(width: 7),
              Flexible(
                child: IntrinsicWidth(
                  child: InkWell(
                    onTap: () async => await pickManagerImage(context),
                    child: widget.team.managerImage != null ?
                      CircleAvatar(radius: 18, backgroundImage: MemoryImage(fromBase64ToByte(widget.team.managerImage!))) :                  
                      const CircleAvatar(radius: 18, backgroundImage: AssetImage("lib/assets/others/no image.jpg")
                    )
                  ),
                ),
              ),
        
              const SizedBox(width: 7),               
              Flexible(
                child: IntrinsicWidth(
                  child: TextField(
                    controller: teamManagerNameController, 
                    onChanged: (value) async => await updateTeamManagerName(value), 
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ), 
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true
                    ),
                  ),
                ),
              ),
            ],
          ) ,

        ]
      ),
    ) ;
  }
}