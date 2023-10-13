import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class CustomAppBar extends StatelessWidget {

  final String pageTitle;
  final bool canNavigateBack;
  final Function? goBack;

  const CustomAppBar(this.pageTitle, {super.key, this.canNavigateBack = false, this.goBack});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      leading: canNavigateBack && goBack != null? InkWell(
        onTap: () => goBack!(),
        child: const Icon(Icons.arrow_back)
      ) 
      : Container(),
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