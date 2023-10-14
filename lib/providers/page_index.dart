import 'package:flutter/material.dart';

// making pageIndex a global state accessible from everywhere using Provider
class PageIndexModel extends ChangeNotifier {

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void updatePageIndex(int newValue) {
    _pageIndex = newValue;
    notifyListeners();
  }

}