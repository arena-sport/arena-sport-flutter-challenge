import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:arena/views/home_screen/noticias_view/noticias.dart';
import 'package:arena/views/home_screen/partidos_view/partidos.dart';
import 'package:arena/views/home_screen/teams_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final queryString = '''
    query HomeScreenData {
      teams {
        name
        logo
      }

      games {
        event_date
        homeTeam {
        team_id
        name
        logo
      }
      awayTeam {
        team_id
        name
        logo
      }
      goalsHomeTeam
      goalsAwayTeam
      }

      notices {
        title
        urlToImage
        publishedAt
      }
    }  
    ''';

    return Query(
      options: QueryOptions(
        documentNode: gql(queryString),
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
        print(result.data['games']);
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
