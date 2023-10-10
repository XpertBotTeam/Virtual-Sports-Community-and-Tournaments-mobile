import 'package:flutter/material.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/screens/customize_screen.dart';
import 'package:lineupmaster/screens/lineups_screen.dart';
import 'package:lineupmaster/screens/settings_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/navbar/navbar_button.dart';
import 'package:provider/provider.dart';

class CustomBottomNavbar extends StatelessWidget {

  final void Function(int, Widget?) onBtnClick; 

  const CustomBottomNavbar(this.onBtnClick, {super.key});

  @override
  Widget build(BuildContext context) {

    final pageIndexModel = Provider.of<PageIndexModel>(context); 

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: secondaryColor,
          height: MediaQuery.of(context).size.height * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarButton(
                fileName: "home.svg", 
                label: "Home", 
                onPressed: () { onBtnClick(0, CustomizeScreen()); },
                isSelected: pageIndexModel.pageIndex == 0,
              ),

              NavBarButton(
                fileName: "line up.svg", 
                label: "Line Ups",
                onPressed: () { onBtnClick(1, const LineUpsScreen()); },
                isSelected: pageIndexModel.pageIndex == 1,
              ),

              NavBarButton(
                fileName: "football field.svg", 
                label: "Pitches",
                onPressed: () { onBtnClick(2, null); },
                isSelected: pageIndexModel.pageIndex == 2,
              ),

              NavBarButton(
                fileName: "settings.svg", 
                label: "Settings",
                onPressed: () { onBtnClick(3, const SettingsScreen()); },
                isSelected: pageIndexModel.pageIndex == 3,
              ),
            ]
          ),
        )
      ) ;   

  }
}