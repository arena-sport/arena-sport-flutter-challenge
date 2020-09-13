import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graph_client.dart';

import 'package:arena/views/home_screen/noticias_view/noticias.dart';
import 'package:arena/views/home_screen/partidos_view/partidos.dart';
import 'package:arena/views/home_screen/teams_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(GraphClient.homeScreenQuery),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          print('exception!');
          return Container();
        }
        if (result.loading) {
          print('loading!');
          return Container();
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 8),
              TeamsListView(teams: result.data['teams']),
              Partidos(
                games: result.data['games'],
              ),
              Noticias(
                news: result.data['notices'],
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
