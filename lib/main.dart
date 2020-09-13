import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'client.dart';

import 'package:arena/providers/tab-provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'widgets/global/styled_app_bar.dart';
import 'widgets/global/styled_bottom_navigation_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GraphQLProvider(
      client: Config.initializeClient(),
      child: MaterialApp(
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
    ),
  );
}
