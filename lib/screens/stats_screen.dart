import 'package:arena/views/stats_screen/information_list_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graph_client.dart';
import '../views/stats_screen/information_list_view.dart';
import '../views/stats_screen/comparison_view.dart';
import '../views/stats_screen/previous_games_view.dart';
import 'package:arena/views/stats_screen/goal_averages.dart';
import 'package:arena/views/stats_screen/scorers.dart';

class StatsScreen extends StatelessWidget {
  Widget get _extraInfo {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          PreviousGamesView(),
          Divider(thickness: 2.0),
          GoalAverages(),
          Divider(thickness: 2.0),
          Scorers(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: gql(GraphClient.statsScreenQuery)),
      builder: (result, {fetchMore, refetch}) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              InformationListView(),
              ComparisonView(comparison: result.data['compareTeams']),
              _extraInfo,
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
