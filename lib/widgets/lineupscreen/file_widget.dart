import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/screens/customize_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:provider/provider.dart';

class FileWidget extends StatelessWidget {

  final Team team;
  final Map<String, ImageProvider> imagesCache;
  final bool insideFolder;  

  const FileWidget(this.team, {super.key, required this.imagesCache, this.insideFolder = false});

  @override
  Widget build(BuildContext context) {
    
    final pageScreenModel = Provider.of<PageScreenModel>(context);
    final pageIndexModel = Provider.of<PageIndexModel>(context); 

    return InkWell(
      onTap: () { 
        pageIndexModel.updatePageIndex(0);
        pageScreenModel.updatePageScreen(CustomizeScreen(team: team));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: insideFolder? lightGray : creamColor,
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
          leading: 
            imagesCache[team.teamLogo] != null ?
              Image(image: imagesCache[team.teamLogo]!, height: 38, width: 35, fit: BoxFit.cover,) :
              Image(image: MemoryImage(fromBase64ToByte(team.teamLogo)), height: 38, width: 38, fit: BoxFit.cover,),
          
          title: Text(
            team.teamName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            )
          )
        ),
      ),
    );
  }
}