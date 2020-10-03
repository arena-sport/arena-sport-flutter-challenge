import 'package:flutter/material.dart';

import 'package:arena/widgets/previous_game.dart';

class PreviousGamesView extends StatelessWidget {
  const PreviousGamesView({
    Key key,
    this.homeTeamGames,
    this.oppTeamGames,
  }) : super(key: key);

  final List<dynamic> homeTeamGames;
  final List<dynamic> oppTeamGames;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'partidos previos'.toUpperCase(),
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: homeTeamGames
                      .map((game) => PreviousGame(game: game))
                      .toList(),
                ),
              ),
              Expanded(
                child: Column(
                  children: oppTeamGames
                      .map((game) => PreviousGame(game: game))
                      .toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
