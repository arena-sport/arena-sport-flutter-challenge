import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'package:arena/screens/stats_screen.dart';

import 'widgets/global/styled_app_bar.dart';
import 'widgets/global/styled_bottom_navigation_bar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Arena',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: StyledAppBar(),
        body: HomeScreen(),
        bottomNavigationBar: StyledBottomNavigationBar(),
      ),
    ),
  );
}
