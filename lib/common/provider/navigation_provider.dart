import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currenindex = 0;

  int get currentindex => _currenindex;

  void changeIndex(int newIndex) {
    if (_currenindex != newIndex) {
      _currenindex = newIndex;
      notifyListeners();
    }
  }
}
