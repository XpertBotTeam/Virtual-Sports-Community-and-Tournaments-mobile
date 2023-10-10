import 'package:flutter/material.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:lineupmaster/widgets/navbar/custom_bottom_navbar.dart';
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
   
    void onBtnClick(int index, Widget? screen) {
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

      bottomNavigationBar: CustomBottomNavbar(onBtnClick)
    );
  }
}