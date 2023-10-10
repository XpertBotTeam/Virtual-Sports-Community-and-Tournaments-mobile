import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/data/repositories/team_repository.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/appbar/custom_appbar.dart';
import 'package:lineupmaster/widgets/custom_textfield.dart';


class CreateTeamContent extends StatefulWidget {
  const CreateTeamContent({super.key});

  @override
  State<CreateTeamContent> createState() => _CreateTeamContentState();
}

class _CreateTeamContentState extends State<CreateTeamContent> {

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
  
  pickImage(context) async {
    String? imageB64 = await pickGalleryImage(context);
    if (imageB64 != null) {
      setState(() { selectedImage = fromBase64ToByte(imageB64); });
    }
  }

  createTeam() {
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
      TeamRepository.insertTeam(team);
    }   
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12),
        child: const CustomAppBar("Create New Team"),
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
                      onPressed: () => createTeam(), 
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
    );
  }
}