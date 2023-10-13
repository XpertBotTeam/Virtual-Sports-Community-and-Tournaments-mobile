import 'package:flutter/material.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:lineupmaster/screens/customize_screen.dart';
import 'package:lineupmaster/screens/lineups_screen.dart';
import 'package:lineupmaster/screens/settings_screen.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/dialogs/pitch_bottom_sheet.dart';
import 'package:lineupmaster/widgets/navbar/navbar_button.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
 
  final PageStorageBucket bucket = PageStorageBucket(); // to maintain page state when switching
  
  @override
  Widget build(BuildContext context) {

    final pageScreenModel = Provider.of<PageScreenModel>(context);
    final pageIndexModel = Provider.of<PageIndexModel>(context); 
    final selectedTeamModel = Provider.of<SelectedTeamModel>(context);    

    openChoosePitchDialog() {
      Team? selectedTeam = selectedTeamModel.selectedTeam;

      if (selectedTeam == null) {
        return;
      }

      showModalBottomSheet(
        context: context, 
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
          )
        ),
        backgroundColor: creamColor,
        builder: (context) {
          return PitchBottomSheet(selectedTeam: selectedTeam, selectedTeamModel: selectedTeamModel);
        });

    }


    void modifyScreenStates(int index, Widget? screen) {
      pageIndexModel.updatePageIndex(index);
      if (screen != null) {
        pageScreenModel.updatePageScreen(screen);
      }
    }

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: pageScreenModel.pageScreen,
      ),

      bottomNavigationBar: BottomAppBar(
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
                onPressed: () => modifyScreenStates(0, const CustomizeScreen()),
                isSelected: pageIndexModel.pageIndex == 0,
              ),

              NavBarButton(
                fileName: "line up.svg", 
                label: "Line Ups",
                onPressed: () => modifyScreenStates(1, const LineUpsScreen()),
                isSelected: pageIndexModel.pageIndex == 1,
              ),

              NavBarButton(
                fileName: "football field.svg", 
                label: "Pitches",
                onPressed: () { 
                  openChoosePitchDialog();                
                },
                isSelected: pageIndexModel.pageIndex == 2,
              ),

              NavBarButton(
                fileName: "settings.svg", 
                label: "Settings",
                onPressed: () => modifyScreenStates(3, const SettingsScreen()),
                isSelected: pageIndexModel.pageIndex == 3,
              ),
            ]
          ),
        )
      ) 
    );
  }
}