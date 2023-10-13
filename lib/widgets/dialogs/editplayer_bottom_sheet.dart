import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/data/models/player_card.dart';
import 'package:lineupmaster/data/repositories/player_card_repository.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/utils/utils.dart';
import 'package:lineupmaster/widgets/circleavatar_with_button.dart';
import 'package:lineupmaster/widgets/custom_textfield.dart';
import 'package:sqflite/sqflite.dart';

class EditPlayerBottomSheet extends StatefulWidget {

  final PlayerCard player;
  final Database db;
  final Function refreshSquad;

  const EditPlayerBottomSheet(this.player, {super.key, required this.db, required this.refreshSquad});

  @override
  State<EditPlayerBottomSheet> createState() => _EditPlayerBottomSheetState();
}


class _EditPlayerBottomSheetState extends State<EditPlayerBottomSheet> {

  late TextEditingController starterNameController;
  late TextEditingController starterNoController;
  late TextEditingController backUpNameController;
  late TextEditingController backUpNumberController;
  late PlayerCardRepository playerCardRepository;


  TextStyle inputCustomStyle = const TextStyle(
    letterSpacing: 1.05,
    fontWeight: FontWeight.bold,
    fontSize: 17
  );

  pickImage(context) async {
    String? imageB64 = await pickGalleryImage(context);
    if (imageB64 != null) {
      widget.player.starterImage = imageB64;
      playerCardRepository.updatePlayerCard(widget.player);
      setState(() {}); // to refresh dialog
      widget.refreshSquad();
    }
  }

  saveStarterName(String value) {
    widget.player.starterName = value;
    playerCardRepository.updatePlayerCard(widget.player);
    widget.refreshSquad();
  }

  saveStarterNo(String numb) {
    if (numb.isEmpty) {
      widget.player.starterNo = null;
    }
    else {
      widget.player.starterNo = int.parse(numb);
    }
    playerCardRepository.updatePlayerCard(widget.player);
    widget.refreshSquad();
  }

  saveBackupName(String value) {
    widget.player.backupName = value;
    playerCardRepository.updatePlayerCard(widget.player);
    widget.refreshSquad();
  }  

  saveBackupNo(String value) {
    if (value.isEmpty) {
      widget.player.backupNo = null;
    }
    else {
      widget.player.backupNo = int.parse(value);
    }
    playerCardRepository.updatePlayerCard(widget.player);
    widget.refreshSquad();
  }
    
  
  @override
  void initState() {
    super.initState();
    PlayerCard player = widget.player;
    playerCardRepository = PlayerCardRepository(widget.db);
    starterNameController = TextEditingController(text: player.starterName);
    starterNoController = TextEditingController(text: player.starterNo == null? "" : "${player.starterNo}");
    backUpNameController = TextEditingController(text: player.backupName);
    backUpNumberController = TextEditingController(text: player.backupNo == null? "" : "${player.backupNo}");
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Player Card"),
            InkWell(
              onTap: () => { Navigator.pop(context) },
              child: SvgPicture.asset(
                "lib/assets/icons/close without bg.svg",
                height: 20,
                width: 20,       
              ),
            )
          ],
      ),
      content: SizedBox(
        height: 450,
        width: 200,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                widget.player.starterImage != null ?
                    CircleAvatarWithButton(onTap: pickImage, byteImage: fromBase64ToByte(widget.player.starterImage!), playerBox: true,) :
                    CircleAvatarWithButton(onTap: pickImage, playerBox: true),
                const SizedBox(height: 20),
                // starter name
                SizedBox(
                  width: double.infinity,
                  child: Text("NAME", style: inputCustomStyle)
                ),
                CustomTextField(starterNameController, onChange: saveStarterName, color: Colors.white,),
                const SizedBox(height: 15),

                // starter no
                SizedBox(
                  width: double.infinity,
                  child: Text("NUMBER", style: inputCustomStyle)
                ),
                CustomTextField(starterNoController, onChange: saveStarterNo, color: Colors.white, numeric: true,),
                const SizedBox(height: 15),
              
                // back up name
                SizedBox(
                  width: double.infinity,
                  child: Text("BACK UP NAME", style: inputCustomStyle)
                ),
                CustomTextField(backUpNameController, onChange: saveBackupName, color: Colors.white,),
                const SizedBox(height: 15),

                // back up number
                SizedBox(
                  width: double.infinity,
                  child: Text("BACK UP NUMBER", style: inputCustomStyle)
                ),
                CustomTextField(backUpNumberController, onChange: saveBackupNo, color: Colors.white, numeric: true),
                const SizedBox(height: 15),
              ],
            )
          ],
        ),
      ),
    
    );

  }
}