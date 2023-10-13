import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/data/models/folder.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/folder_repository.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/screens/create_team_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/appbar/custom_appbar.dart';
import 'package:lineupmaster/widgets/dialogs/create_folder_dialog.dart';
import 'package:lineupmaster/widgets/lineupscreen/file_widget.dart';
import 'package:lineupmaster/widgets/lineupscreen/folder_widget.dart';
import 'package:lineupmaster/widgets/section_title.dart';
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
  Map<String, ImageProvider> imagesCache = {};
  bool createFileInsideFolderRequested = false;

  reRenderParent() {
    setState(() {});
  }

  updateCreateFileRequested(value) {
    setState(() => createFileInsideFolderRequested = value);
  }
    
  Future openFolderDialog() =>
    showDialog(
      context: context, 
      barrierDismissible: false, // when the user press outside the dialog it doesnt pop up
      builder: (context) => const CreateFolderDialog()
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  fetchData() async {

    final Database db = await SQLHelper.db();
    final FolderRepository folderRepository = FolderRepository(db);
    final TeamRepository teamRepository = TeamRepository(db);

    folders = await folderRepository.getFolders();
    teams = await teamRepository.getIndependentTeams();

    // caching folder images
    folders?.forEach((folder) {
      if (!imagesCache.containsKey(folder.folderLogo)) {
        ImageProvider folderImage = Image.memory(fromBase64ToByte(folder.folderLogo)).image;
        imagesCache[folder.folderLogo] = folderImage;
      }      
    });
    // caching team images
    teams?.forEach((team) {
      if (!imagesCache.containsKey(team.teamLogo)) {
        ImageProvider teamImage = Image.memory(fromBase64ToByte(team.teamLogo)).image;
        imagesCache[team.teamLogo] = teamImage;
      }      
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    if (folders == null || teams == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGray,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12),
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
                    onTap: () { openFolderDialog(); } ,
                    child: SvgPicture.asset(
                      "lib/assets/icons/add folder.svg",
                      width: 28,  
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      if (selectedFolders.isNotEmpty) {
                        setState(() {
                            createFileInsideFolderRequested = true;
                        });
                      }
                      else {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const CreateTeamScreen())); 
                        }
                    } ,
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
                ...folders!.map((folder) {
                  return FolderWidget(
                    folder,
                    selectedFolders: selectedFolders, 
                    imagesCache: imagesCache,
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
                ...teams!.map((team) {
                  return FileWidget(team, imagesCache: imagesCache);
                }).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}