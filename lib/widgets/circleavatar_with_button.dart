import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class CircleAvatarWithButton extends StatelessWidget {

  final Uint8List? byteImage;
  final Function onTap;
  final double radius;
  final double buttonSize;
  
  const CircleAvatarWithButton({super.key, this.byteImage, required this.onTap, this.radius = 35, this.buttonSize = 25});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () { onTap(context);} ,
            child: 
              byteImage == null ?
            CircleAvatar(
                backgroundImage: const AssetImage("lib/assets/others/no image.jpg"),
                radius: radius
            ) :
            CircleAvatar(
                backgroundImage: MemoryImage(byteImage!),
                radius: radius
            )
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: buttonSize,
              width: buttonSize,
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