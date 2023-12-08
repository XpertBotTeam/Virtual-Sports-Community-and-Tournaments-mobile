import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/screens/create_team_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class TeamInfo extends StatefulWidget {
  final Team team;
  final List<PlayerCard> players;
  final Database db;

  const TeamInfo(
      {super.key, required this.team, required this.players, required this.db});

  @override
  State<TeamInfo> createState() => _TeamInfoState();
}

class _TeamInfoState extends State<TeamInfo> {
  @override
  Widget build(BuildContext context) {
    // class data fields
    final pageScreenModel = Provider.of<PageScreenModel>(context);
    TextEditingController teamNameController =
        TextEditingController(text: widget.team.teamName);
    TextEditingController teamManagerNameController =
        TextEditingController(text: widget.team.managerName);
    TextEditingController teamSubtitleController =
        TextEditingController(text: widget.team.teamSubtitle ?? "Subtitle");
    TeamRepository teamRepository = TeamRepository(widget.db);

    // updating team name in the db
    updateTeamName(newName) async {
      widget.team.teamName = newName;
      await teamRepository.updateTeam(widget.team);
    }

    // updating team managerName in the db
    updateTeamManagerName(newName) async {
      widget.team.managerName = newName;
      await teamRepository.updateTeam(widget.team);
    }

    // updating team subtitle in the db
    updateSubtitle(newSubtitle) async {
      widget.team.teamSubtitle = newSubtitle;
      await teamRepository.updateTeam(widget.team);
    }

    // picking manager image, storing it in the db, and updating state to reflect changes in real-time
    pickManagerImage(context) async {
      String? storedImagePath = await pickAndDuplicateImage(context);
      if (storedImagePath != null) {
        widget.team.managerImage = storedImagePath;
        await teamRepository.updateTeam(widget.team);
        setState(() {});
      }
    }

    // picking team image, storing it in the db, and updating state to reflect changes in real-time
    pickTeamImage(context) async {
      String? storedImagePath = await pickAndDuplicateImage(context);
      if (storedImagePath != null) {
        widget.team.teamLogo = storedImagePath;
        await teamRepository.updateTeam(widget.team);
        setState(() {});
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: InkWell(
                          onTap: () async => await pickTeamImage(context),
                          child: Image.file(File(widget.team.teamLogo),
                              width: 45, height: 45, fit: BoxFit.contain))),
                  const SizedBox(width: 10),
                  Flexible(
                    child: IntrinsicWidth(
                      child: TextField(
                        controller: teamNameController,
                        onChanged: (value) async => await updateTeamName(value),
                        style: const TextStyle(
                            color: whiteColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w900),
                        decoration: const InputDecoration(
                            border: InputBorder.none, isDense: true),
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
                onTap: () {
                  pageScreenModel.updatePageScreen(const CreateTeamScreen());
                },
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
              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20),
          decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero),
        ),
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
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: IntrinsicWidth(
                child: InkWell(
                    onTap: () async => await pickManagerImage(context),
                    child: widget.team.managerImage != null
                        ? CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                FileImage(File(widget.team.managerImage!)))
                        : const CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage("lib/assets/others/no image.jpg"))),
              ),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: IntrinsicWidth(
                child: TextField(
                  controller: teamManagerNameController,
                  onChanged: (value) async =>
                      await updateTeamManagerName(value),
                  style: const TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      border: InputBorder.none, isDense: true),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
