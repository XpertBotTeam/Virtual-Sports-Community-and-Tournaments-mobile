import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/pitch_options.dart';
import 'package:sqflite/sqflite.dart';

class PitchBottomSheet extends StatefulWidget {

  final SelectedTeamModel selectedTeamModel;
  final Team selectedTeam;

  const PitchBottomSheet({super.key, required this.selectedTeamModel, required this.selectedTeam});

  @override
  State<PitchBottomSheet> createState() => _PitchBottomSheetState();
}

class _PitchBottomSheetState extends State<PitchBottomSheet> {

  changeThemeColor(String color) async {
    // retrieving selectedTeam from global state
    Team team = widget.selectedTeamModel.selectedTeam!;
    // updating team's theme color
    team.themeColor = color;
    // storing updated team in the global state
    widget.selectedTeamModel.updateSelectedTeam(team);
    // storing updated team in the db
    Database db = await SQLHelper.db();
    TeamRepository teamRepository = TeamRepository(db);
    teamRepository.updateTeam(team);
    // refresh the page to reflect changes
    setState(() {});      
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: creamColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 100,
            color: secondaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context), 
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(2),
                        shape: const CircleBorder(),
                        minimumSize: const Size(23.0, 23.0),
                        backgroundColor: creamColor
                      ),
                      child: const Icon(Icons.close, color: Colors.black, size: 15,),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 25),
                  child: Text(
                    "Change Pitch",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold
                    ),  
                  ),
                ),
              ],
            ),
          ),
    
          // Body
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PitchOption(
                  imageName: "green.png", 
                  label: "Green Pitch", 
                  isSelected: widget.selectedTeam.themeColor == 'green',
                  colorName: "green",
                  onPitchChange: changeThemeColor,
                ),
                PitchOption(
                  imageName: "blue.png", 
                  label: "Blue Pitch", 
                  isSelected: widget.selectedTeam.themeColor == 'blue',
                  colorName: "blue",
                  onPitchChange: changeThemeColor,
                ),
                PitchOption(
                  imageName: "red.png", 
                  label: "Red Pitch", 
                  isSelected: widget.selectedTeam.themeColor == 'red',
                  colorName: "red",
                  onPitchChange: changeThemeColor,
                ),
                PitchOption(
                  imageName: "purple.webp", 
                  label: "Purple Pitch", 
                  isSelected: widget.selectedTeam.themeColor == 'purple',
                  colorName: "purple",
                  onPitchChange: changeThemeColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}