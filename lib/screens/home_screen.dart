import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:arena/views/home_screen/noticias_view/noticias.dart';
import 'package:arena/views/home_screen/partidos_view/partidos.dart';
import 'package:arena/views/home_screen/teams_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final queryString = '''
    query Teams {
      teams {
      name
      logo
      }
    }  
    ''';

    return Query(
      options: QueryOptions(
        documentNode: gql(queryString),
        pollInterval: 1000000000000,
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
        print(result.data);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 8),
              TeamsListView(),
              Partidos(),
              Noticias(),
              SizedBox(height: 8),
              Partidos(),
            ],
          ),
        );
      },
    );
  }
}
