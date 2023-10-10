import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/data/models/folder.dart';

class TemporaryFileWidget extends StatefulWidget {

  final Function updateCreateFileRequested;
  final Function fetchData;
  final Folder folder;

  const TemporaryFileWidget({
    super.key,
    required this.updateCreateFileRequested,
    required this.fetchData,
    required this.folder
  });

  @override
  State<TemporaryFileWidget> createState() => _TemporaryFileWidgetState();
}


class _TemporaryFileWidgetState extends State<TemporaryFileWidget> {

  final TextEditingController teamNameController = TextEditingController();
  Uint8List? selectedImage;
  bool errorOccured = false;


  pickImage(context) async {
    String? imageB64 = await pickGalleryImage(context);
    if (imageB64 != null) {
      setState(() { selectedImage = fromBase64ToByte(imageB64); });
    }
  }

  saveFile() {
    if (teamNameController.text != "" && selectedImage != null) {
      Team team = Team(
        teamLogo: base64Encode(selectedImage!), 
        teamSubtitle: "", 
        teamName: teamNameController.text,
        folderId: widget.folder.folderId
      );
      TeamRepository.insertTeam(team);
      widget.updateCreateFileRequested(false);
      widget.fetchData();
    }
    else {
      errorOccured = true;
    }
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
        )
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        leading: selectedImage == null ? 
            InkWell(
              child: Image.asset("lib/assets/others/add image.png"),
              onTap: () => pickImage(context),
            ) : 
            Image.memory(selectedImage!),
        title: TextField(
          controller: teamNameController,
          autofocus: true,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter team name...",
            isDense: true
          ),
        ),
        trailing: GestureDetector(
          onTap: () => saveFile(),
          child: const Icon(Icons.check, color: Colors.green)
        ),        
      )
    );
  }
}