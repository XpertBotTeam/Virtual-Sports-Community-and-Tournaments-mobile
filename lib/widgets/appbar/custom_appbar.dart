import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class CustomAppBar extends StatelessWidget {

  final String pageTitle;

  const CustomAppBar(this.pageTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: secondaryColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          pageTitle,
          style: const TextStyle(
            color: blackColor,
            fontWeight: FontWeight.bold
          ), 
        ),
      ),
      centerTitle: true,
      elevation: 3,
    );
  }
}