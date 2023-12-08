import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/screens/customize_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:provider/provider.dart';

class FileWidget extends StatelessWidget {
  final Team team;
  final bool insideFolder;

  const FileWidget(this.team, {super.key, this.insideFolder = false});

  @override
  Widget build(BuildContext context) {
    final pageScreenModel = Provider.of<PageScreenModel>(context);
    final pageIndexModel = Provider.of<PageIndexModel>(context);
    final selectedTeamModel = Provider.of<SelectedTeamModel>(context);

    return InkWell(
        onTap: () {
          selectedTeamModel.updateSelectedTeam(team);
          pageIndexModel.updatePageIndex(0);
          pageScreenModel.updatePageScreen(const CustomizeScreen());
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: insideFolder ? lightGray : creamColor,
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: secondaryColor,
                ),
              )),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
            dense: true,
            visualDensity: const VisualDensity(vertical: -2),
            leading: Image.file(File(team.teamLogo)),
            title: Text(team.teamName,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ),
        ));
  }
}
