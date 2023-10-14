import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/data/sql_helper.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/screens/customize_screen.dart';
import 'package:lineupmaster/screens/lineups_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/appbar/custom_appbar.dart';
import 'package:lineupmaster/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';


class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {

  TextEditingController teamNameController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  Uint8List? selectedImage;
  String errMsg = "";

  TextStyle customTextStyle = 
    const TextStyle(
      color: whiteColor,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.05
  ); 

  @override
  void dispose() {
    super.dispose();
    teamNameController.dispose();
    subtitleController.dispose();
  }  

  // method to pick image from gallery and store the result in selectedImage
  pickImage(context) async {
    String? imageB64 = await pickGalleryImage(context);
    if (imageB64 != null) {
      setState(() { selectedImage = fromBase64ToByte(imageB64); });
    }
  }

  // method invoked when user presses on create button
  createTeam(pageIndexModel, pageScreenModel, selectedTeamModel) async {
    if (selectedImage == null) {
      errMsg = "Team Logo must be specified";
    }
    else if (teamNameController.text == "") {
      errMsg = "Team Name must be specified";
    }
    else {
      // create team 
      errMsg = "";
      Team team = Team(
        teamLogo: base64Encode(selectedImage!), 
        teamName: teamNameController.text,
        teamSubtitle: subtitleController.text, 
      );
      TeamRepository teamRepository = TeamRepository(await SQLHelper.db());
      await teamRepository.insertTeam(team);

      // updating global states
      Team? lastTeam = await teamRepository.getLastTeam();
      selectedTeamModel.updateSelectedTeam(lastTeam);
      if (pageIndexModel.pageIndex == 0) {
        pageScreenModel.updatePageScreen(const CustomizeScreen());
      }
      else {
        pageScreenModel.updatePageScreen(const LineUpsScreen());                          
      }
    }   
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {    
    final pageIndexModel = Provider.of<PageIndexModel>(context); 
    final pageScreenModel = Provider.of<PageScreenModel>(context);
    final selectedTeamModel = Provider.of<SelectedTeamModel>(context);
    
    void onGoBack() {
      if (pageIndexModel.pageIndex == 0) {
        pageScreenModel.updatePageScreen(const CustomizeScreen());
      }
      else {
        pageScreenModel.updatePageScreen(const LineUpsScreen());
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12),
          child: CustomAppBar("Create New Team", canNavigateBack: true, goBack: onGoBack),
        ),
        body: Stack(
          children: [
            // layer 1 : image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("lib/assets/stadiums/ucl stadium.jpg"),
                ),
              ),
            ),
            // layer 2 : black
            Opacity(
              opacity: 0.7,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
              ),
            ),
            // layer 3: content
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8) ,
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                
                  selectedImage == null ?
                    const Center(
                      child: CircleAvatar(
                          backgroundImage: AssetImage("lib/assets/others/no image.jpg"),
                          radius: 40
                      ),
                    ) :
                    Center(
                      child: CircleAvatar(
                          backgroundImage: MemoryImage(selectedImage!),
                          radius: 40
                      ),
                    ),
                   
                  const SizedBox(height: 10), 
                  Center(
                    child: ElevatedButton(
                      onPressed: () => pickImage(context), 
                      style: ElevatedButton.styleFrom(backgroundColor: lightGray, padding: const EdgeInsets.fromLTRB(15, 2, 15, 2)),
                      child: 
                        selectedImage == null ?
                          const Text("Select Logo", style: TextStyle(color: blackColor, fontSize: 15)):
                          const Text("Change Logo", style: TextStyle(color: blackColor, fontSize: 15))
                    ),
                  ),
                  const SizedBox(height: 15), 
                  Text("NAME", style: customTextStyle),
                  CustomTextField(teamNameController, shiny: false),
                  
                  const SizedBox(height: 15), 
                  Text("SUBTITLE", style: customTextStyle),
                  CustomTextField(subtitleController, shiny: false),
                
                  errMsg != "" ? 
                    Center(
                      child: Text(
                        errMsg,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16                         
                        ),
                      )
                    )
                    : Container(),
                
                  const SizedBox(height: 15), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async => await createTeam(pageIndexModel, pageScreenModel, selectedTeamModel), 
                        style: ElevatedButton.styleFrom(backgroundColor: lightGray, padding: const EdgeInsets.fromLTRB(15, 2, 15, 2)),
                        child: const Text("Create", style: TextStyle(color: blackColor, fontSize: 15),)
                      ),
                    ],
                  ),
                
                ],
                    ),
            ),
          ],
        ), 
      ),
    );
  }
}