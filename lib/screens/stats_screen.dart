import 'package:arena/views/horizontal_list_views/information_list_view.dart';
import 'package:flutter/material.dart';

import '../views/horizontal_list_views/information_list_view.dart';
import '../views/comparison_view/comparison_view.dart';
import '../views/previous_games_view.dart';

class StatsScreen extends StatelessWidget {
  Widget get extraInfo {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          PreviousGamesView(),
          Divider(
            thickness: 2.0,
          ),
          Container(
            height: 100,
          ),
          Divider(
            thickness: 2.0,
          ),
          Container(height: 150),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          InformationListView(),
          ComparisonView(),
          extraInfo,
        ],
      ),
    );
  }
}
