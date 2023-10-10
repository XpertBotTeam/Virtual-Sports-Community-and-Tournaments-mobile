import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/utils/colors.dart';

class SettingsButton extends StatelessWidget {

  final String title;
  final String image;

  const SettingsButton({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {

    double generalPaddingLeft = MediaQuery.of(context).size.width / 16;

    return Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: creamColor,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: secondaryColor,
              ),
            )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: generalPaddingLeft, right: 25, top: 10, bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: double.infinity,
                  child: SvgPicture.asset("lib/assets/$image", height: double.infinity)
                ) ,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SvgPicture.asset(
                        "lib/assets/icons/arrow right.svg",
                        color: secondaryColor,
                        height: 20,
                      )
                    ],
                  ),
                )    
              ]
            ),
          )
        );
  }
}