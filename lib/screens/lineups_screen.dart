import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/data/models/folder.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/folder_repository.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/screens/create_team_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/appbar/custom_appbar.dart';
import 'package:lineupmaster/widgets/dialogs/create_folder_dialog.dart';
import 'package:lineupmaster/widgets/lineupscreen/file_widget.dart';
import 'package:lineupmaster/widgets/lineupscreen/folder_widget.dart';
import 'package:lineupmaster/widgets/section_title.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class LineUpsScreen extends StatefulWidget {
  const LineUpsScreen({super.key});

  @override
  State<LineUpsScreen> createState() => _LineUpsScreenState();
}

class _LineUpsScreenState extends State<LineUpsScreen> {
  List<Folder>? folders;
  List<Folder> selectedFolders = [];
  List<Team>? teams;
  bool createFileInsideFolderRequested = false;

  reRenderParent() {
    setState(() {});
  }

  rerenderParentAndFetch() async {
    fetchData();
    setState(() {});
  }

  updateCreateFileRequested(value) {
    setState(() => createFileInsideFolderRequested = value);
  }

  Future openFolderDialog() => showDialog(
      context: context,
      barrierDismissible:
          false, // when the user press outside the dialog it doesnt pop up
      builder: (context) =>
          CreateFolderDialog(reRenderParent: rerenderParentAndFetch));

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final Database db = await SQLHelper.db();
    final FolderRepository folderRepository = FolderRepository(db);
    final TeamRepository teamRepository = TeamRepository(db);

    folders = await folderRepository
        .getFolders(); // returns folders with teams inside them
    teams = await teamRepository
        .getIndependentTeams(); // returns teams that are outside a folders

    // re-redner page after fetching folders and teams
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pageScreenModel = Provider.of<PageScreenModel>(context);

    if (folders == null || teams == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGray,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 12),
          child: const CustomAppBar("Line Ups"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      openFolderDialog();
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/add folder.svg",
                      width: 28,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      print("sf: ${selectedFolders.length}");
                      if (selectedFolders.isNotEmpty) {
                        print("is not empty");
                        setState(() => createFileInsideFolderRequested = true);
                      } else {
                        print("is empty");
                        pageScreenModel
                            .updatePageScreen(const CreateTeamScreen());
                      }
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/add file.svg",
                      width: 28,
                    ),
                  ),
                ],
              ),
            ),

            // folders
            const SectionTitle("Folders"),
            // returning folders,
            Column(
              children: [
                // if there are no folders
                if (folders!.isEmpty)
                  const Center(
                    child: Text("No folders yet."),
                  ),

                ...folders!.map((folder) {
                  return FolderWidget(
                    folder,
                    selectedFolders: selectedFolders,
                    fetchData: fetchData,
                    reRenderParent: reRenderParent,
                    updateCreateFileRequested: updateCreateFileRequested,
                    createFileRequested: createFileInsideFolderRequested,
                  );
                }).toList()
              ],
            ),
            const SizedBox(height: 20),

            // files
            const SectionTitle("Files"),
            // returning teams,
            Column(
              children: [
                if (teams!.isEmpty)
                  const Center(
                    child: Text("No teams yet."),
                  ),
                ...teams!.map((team) {
                  return FileWidget(team);
                }).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
