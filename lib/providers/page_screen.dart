import 'package:flutter/material.dart';
import 'package:lineupmaster/screens/customize_screen.dart';

// making pageScreen a global state accessible from everywhere using Provider
class PageScreenModel extends ChangeNotifier {

  Widget _pageScreen = const CustomizeScreen();

  Widget get pageScreen => _pageScreen;

  void updatePageScreen(Widget screen) {
    _pageScreen = screen;
    notifyListeners();
  }

}