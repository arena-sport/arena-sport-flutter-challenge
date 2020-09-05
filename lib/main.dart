import 'package:arena/screens/stats_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

import 'widgets/styled_app_bar.dart';
import 'widgets/styled_bottom_navigation_bar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Arena',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: StyledAppBar(),
        body: StatsScreen(),
        bottomNavigationBar: StyledBottomNavigationBar(),
      ),
    ),
  );
}
