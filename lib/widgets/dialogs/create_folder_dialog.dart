import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/data/models/folder.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/folder_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/circleavatar_with_button.dart';
import 'package:lineupmaster/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class CreateFolderDialog extends StatefulWidget {
  final Function reRenderParent;
  const CreateFolderDialog({super.key, required this.reRenderParent});

  @override
  State<CreateFolderDialog> createState() => _CreateFolderDialogState();
}

class _CreateFolderDialogState extends State<CreateFolderDialog> {
  String? selectedImagePath;
  TextEditingController folderNameController = TextEditingController();
  String? errMsg;

  createFolder() async {
    // checking image is selected
    if (selectedImagePath == null) {
      errMsg = "Folder logo must be specified.";
    }
    // checking name is specified
    else if (folderNameController.text == '') {
      errMsg = "Folder name cannot be empty.";
    }
    // fields are correct
    else {
      errMsg = "";
      Folder folder = Folder(
          folderName: folderNameController.text,
          folderLogo: selectedImagePath!);
      FolderRepository folderRepository =
          FolderRepository(await SQLHelper.db());
      folderRepository.insertFolder(folder);
      Navigator.pop(context);
    }
    // to re-render the widget since there are variables that may have have changed
    setState(() {});
    await widget.reRenderParent();
  }

  pickImage(context) async {
    String? storedImagePath = await pickAndDuplicateImage(context);
    if (storedImagePath != null) {
      setState(() => selectedImagePath = storedImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTeamModel = Provider.of<SelectedTeamModel>(context);
    Team? selectedTeam = selectedTeamModel.selectedTeam;

    // returning appropriate color based on theme color
    Color getButtonColor() {
      if (selectedTeam == null) {
        return primaryColor;
      } else {
        String themeColor = selectedTeam.themeColor;
        if (themeColor == 'green') {
          return primaryColor;
        } else if (themeColor == 'blue') {
          return blueColor;
        } else if (themeColor == 'red') {
          return redColor;
        }
        return purpleColor;
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Create Folder"),
            InkWell(
              onTap: () => {Navigator.pop(context)},
              child: SvgPicture.asset(
                "lib/assets/icons/close without bg.svg",
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
        content: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            height: 260,
            child: Column(children: [
              selectedImagePath != null
                  ? CircleAvatarWithButton(
                      onTap: pickImage,
                      imagePath: selectedImagePath,
                      buttonColor: getButtonColor())
                  : CircleAvatarWithButton(
                      onTap: pickImage, buttonColor: getButtonColor()),
              const SizedBox(height: 20),
              const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "TITLE",
                    style: TextStyle(
                        letterSpacing: 1.05, fontWeight: FontWeight.w500),
                  )),
              CustomTextField(folderNameController),
              if (errMsg != null)
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  child: Center(
                    child: Text(
                      errMsg!,
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
              Expanded(child: Container()),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: getButtonColor()),
                    onPressed: () async => await createFolder(),
                    child: const Text("Create")),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
