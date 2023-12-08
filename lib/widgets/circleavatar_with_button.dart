import 'dart:io';

import 'package:flutter/material.dart';

class CircleAvatarWithButton extends StatelessWidget {
  final String? imagePath;
  final Function onTap;
  final double radius;
  final double buttonSize;
  final bool playerBox;
  final Color buttonColor;

  const CircleAvatarWithButton(
      {super.key,
      this.imagePath,
      required this.buttonColor,
      required this.onTap,
      this.radius = 35,
      this.buttonSize = 25,
      this.playerBox = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        GestureDetector(
            onTap: () => onTap(context),
            child: imagePath == null
                ? playerBox
                    ? CircleAvatar(
                        backgroundImage:
                            const AssetImage("lib/assets/others/no pp.png"),
                        radius: radius,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            const AssetImage("lib/assets/others/no image.jpg"),
                        radius: radius)
                : CircleAvatar(
                    backgroundImage: FileImage(File(imagePath!)),
                    radius: radius)),
        Positioned(
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: buttonSize,
            width: buttonSize,
            child: ElevatedButton(
                onPressed: () => onTap(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0)),
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 20),
                )),
          ),
        )
      ]),
    );
  }
}
