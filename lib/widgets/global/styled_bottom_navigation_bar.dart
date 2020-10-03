import 'package:arena/providers/tab-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.shade800,
      // currentIndex: currentTab,
      currentIndex: context.watch<TabProvider>().currentTab,
      items: tabs,
      onTap: (tabIndex) {
        context.read<TabProvider>().setTab(tabIndex);
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
      icon: Image.asset(
        'assets/images/arena_icon.png',
        height: 35.0,
      ),
      title: Text(
        'Arena',
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
