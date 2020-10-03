import 'package:flutter/material.dart';

import 'package:arena/screens/home_screen.dart';
import 'package:arena/screens/stats_screen.dart';

class TabProvider extends ChangeNotifier {
  int _currentTab = 0;
  int get currentTab => _currentTab;
  void setTab(int tab) {
    _currentTab = tab;
    notifyListeners();
  }

  List<Widget> _screens = [
    HomeScreen(),
    StatsScreen(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  Widget get screen {
    return _screens[_currentTab];
  }
}
