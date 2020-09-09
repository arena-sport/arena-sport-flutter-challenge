import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arena/providers/tab-provider.dart';

// import 'screens/home_screen.dart';
// import 'package:arena/screens/stats_screen.dart';

import 'widgets/global/styled_app_bar.dart';
import 'widgets/global/styled_bottom_navigation_bar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Arena',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<TabProvider>(
        create: (context) => TabProvider(),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: StyledAppBar(),
          body: context.watch<TabProvider>().screen,
          bottomNavigationBar: StyledBottomNavigationBar(),
        ),
      ),
    ),
  );
}
