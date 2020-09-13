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
  Widget _extraInfo(comparison) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          PreviousGamesView(
            homeTeamGames:
                comparison != null ? comparison[0]['latest_games'] : [],
            oppTeamGames:
                comparison != null ? comparison[1]['latest_games'] : [],
          ),
          Divider(thickness: 2.0),
          GoalAverages(),
          Divider(thickness: 2.0),
          Scorers(
            homeGoalie: comparison[0]['goalie'],
            oppGoalie: comparison[1]['goalie'],
          ),
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
              if (result.data != null)
                ComparisonView(comparison: result.data['compareTeams']),
              if (result.data != null) _extraInfo(result?.data['compareTeams']),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
