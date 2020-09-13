import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphClient {
  static final link = HttpLink(
    uri: 'http://10.0.0.213:4000/',
  );

  static ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      ),
    );
    return client;
  }

  static const homeScreenQuery = '''
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

  static const statsScreenQuery = '''
  query compare{ 
    compareTeams(teamNames: ["Manchester United", "Liverpool"]) {
    # Section 1: Team Stats in League
		rank
		teamName
		team_id
		results: all {
		win
		draw
		lose
		}
    
    # Section 2: Previous Games
    latest_games {
      fixture_id
      homeTeam {
        name
      }
      awayTeam {
        name
      }
      score
    }
    
    # Section 3: Goal Averages
    goal_averages
    
    # Section 4: Goalies
    goalie {
      player_name
      player_id
      position
      urlToImage
    }
  }
}
''';
}
