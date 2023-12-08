import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/data/models/folder.dart';

class TemporaryFileWidget extends StatefulWidget {
  final Function updateCreateFileRequested;
  final Function fetchData;
  final Folder folder;

  const TemporaryFileWidget(
      {super.key,
      required this.updateCreateFileRequested,
      required this.fetchData,
      required this.folder});

  @override
  State<TemporaryFileWidget> createState() => _TemporaryFileWidgetState();
}

class _TemporaryFileWidgetState extends State<TemporaryFileWidget> {
  final TextEditingController teamNameController = TextEditingController();
  String? selectedImagePath;
  bool errorOccured = false;

  pickImage(context) async {
    String? storedImagePath = await pickAndDuplicateImage(context);
    if (storedImagePath != null) {
      setState(() => selectedImagePath = storedImagePath);
    }
  }

  // method invoked when create file is requested
  saveFile() async {
    // checking required values are filled
    if (teamNameController.text != "" && selectedImagePath != null) {
      // creating team object
      Team team = Team(
          teamLogo: selectedImagePath!,
          teamName: teamNameController.text,
          folderId: widget.folder.folderId);
      // storing team object in the db
      TeamRepository teamRepository = TeamRepository(await SQLHelper.db());
      teamRepository.insertTeam(team);
      // removing createFile request
      widget.updateCreateFileRequested(false);
      // updating parent component to reflect the newly created team
      widget.fetchData();
    }
    // required values missing
    else {
      errorOccured = true;
    }
    // rerender widget to reflect changes (if error occured color with red)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
            color: errorOccured ? Colors.red : lightGray,
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
          leading: selectedImagePath == null
              ? InkWell(
                  child: Image.asset("lib/assets/others/add image.png"),
                  onTap: () => pickImage(context),
                )
              : Image.file(File(selectedImagePath!)),
          title: TextField(
            controller: teamNameController,
            autofocus: true,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter team name...",
                isDense: true),
          ),
          trailing: GestureDetector(
              onTap: () => saveFile(),
              child: const Icon(Icons.check, color: Colors.green)),
        ));
  }
}
