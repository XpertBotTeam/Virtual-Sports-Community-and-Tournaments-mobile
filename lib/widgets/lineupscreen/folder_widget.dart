import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/folder.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/lineupscreen/file_widget.dart';
import 'package:lineupmaster/widgets/lineupscreen/temporary_file_widget.dart';

class FolderWidget extends StatelessWidget {

  final Folder folder;
  final List<Folder> selectedFolders;
  final Function reRenderParent;
  final bool createFileRequested;
  final Function updateCreateFileRequested;
  final Map<String, ImageProvider> imagesCache;
  final Function fetchData;

  const FolderWidget(this.folder, {
    super.key, 
    required this.selectedFolders,
    required this.imagesCache,
    this.createFileRequested = false,  
    required this.updateCreateFileRequested,    
    required this.reRenderParent,
    required this.fetchData
  }) ;


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: creamColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: secondaryColor,
          ),
        )
      ),
      child: ExpansionTile(
        onExpansionChanged: (isExpanded) {
          if (isExpanded) {
            if (createFileRequested) {
              updateCreateFileRequested(false);
            }
            if (selectedFolders.contains(folder)) {
              selectedFolders.remove(folder);
            }
            selectedFolders.add(folder);          
          }
          else {
            if (createFileRequested) {
              updateCreateFileRequested(false);
            }
            selectedFolders.remove(folder);
          }
          reRenderParent();
        },
        textColor: blackColor, // when expanded
        iconColor: blackColor, // when expanded
        backgroundColor: 
          selectedFolders.isNotEmpty && selectedFolders.last == folder ? 
          darkGray : lightGray,
        
        title: ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          leading:
          imagesCache[folder.folderLogo] != null ?  
              Image(image: imagesCache[folder.folderLogo]!, height: 38, width: 35, fit: BoxFit.cover,) :
              Image(image: MemoryImage(fromBase64ToByte(folder.folderLogo)), height: 38, width: 38, fit: BoxFit.cover,),
          
          title: Text(
            folder.folderName, 
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold                      
            ),
          ),        
        ) ,
        children: [
          Column(
            children: [    
              if (folder.teams != null) 
              ...folder.teams!.map((team) {
                return FileWidget(team, imagesCache: imagesCache, insideFolder: true,);
              }),

              if (selectedFolders.isNotEmpty && selectedFolders.last == folder && createFileRequested) 
              TemporaryFileWidget(
                updateCreateFileRequested: updateCreateFileRequested,
                folder: folder,
                fetchData: fetchData
              )        
            ],
          )
        ],
      ),
    );
   
  }
}