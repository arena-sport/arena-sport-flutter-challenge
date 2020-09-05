import 'package:flutter/material.dart';

class StyledBottomNavigationBar extends StatefulWidget {
  @override
  _StyledBottomNavigationBarState createState() =>
      _StyledBottomNavigationBarState();
}

class _StyledBottomNavigationBarState extends State<StyledBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.shade800,
      currentIndex: currentTab,
      items: tabs,
      onTap: (value) {
        setState(() {
          currentTab = value;
        });
      },
    );
  }

  final List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      title: Text(
        'Home',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.multiline_chart,
      ),
      title: Text(
        'Stats',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.local_activity,
      ),
      title: Text(
        'Stats',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.radio,
      ),
      title: Text(
        'Radio',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.network_check,
      ),
      title: Text(
        'Network',
      ),
    ),
  ];
}
