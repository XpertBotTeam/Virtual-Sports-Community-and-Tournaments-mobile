import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class CircleAvatarWithButton extends StatelessWidget {

  final Uint8List? byteImage;
  final Function onTap;
  
  const CircleAvatarWithButton({super.key, this.byteImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () { onTap(context);} ,
            child: 
              byteImage == null ?
            const CircleAvatar(
                backgroundImage: AssetImage("lib/assets/others/no image.jpg"),
                radius: 35
            ) :
            CircleAvatar(
                backgroundImage: MemoryImage(byteImage!),
                radius: 35
            )
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 25,
              width: 25,
              child: ElevatedButton(
                onPressed: () { onTap(context); }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0)
                ),
                child: const Text(
                  "+",
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ),
            ),
          )
        ] 
      ),
      );
  }
}