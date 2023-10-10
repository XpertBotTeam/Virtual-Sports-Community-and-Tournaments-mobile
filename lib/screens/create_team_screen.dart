import 'package:flutter/material.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/widgets/create_team_content.dart';
import 'package:lineupmaster/widgets/navbar/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {

  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  
  final PageStorageBucket bucket = PageStorageBucket(); 
  
  @override
  Widget build(BuildContext context) {
    
    final pageIndexModel = Provider.of<PageIndexModel>(context); 
    final pageScreenModel = Provider.of<PageScreenModel>(context);

    void onBtnPress(int index, Widget? screen) {
      Navigator.of(context).pop();
      pageIndexModel.updatePageIndex(index);
      if (screen != null) {
        pageScreenModel.updatePageScreen(screen);    
      }
    }

    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: const CreateTeamContent(),
        ),
        bottomNavigationBar: CustomBottomNavbar(onBtnPress)
      ),
    );
  }
}