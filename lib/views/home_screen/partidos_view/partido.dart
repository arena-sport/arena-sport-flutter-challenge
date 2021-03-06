import 'package:flutter/material.dart';

class Partido extends StatelessWidget {
  final bool shouldDisplayNotification;
  final game;

  const Partido({this.shouldDisplayNotification, this.game});

  Icon get ringer {
    return Icon(
      Icons.notifications_none,
      size: 24,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamRow(
          game: game,
          ringer: ringer,
          teamString: 'homeTeam',
          shouldDisplayNotification: shouldDisplayNotification,
        ),
        SizedBox(height: 8),
        TeamRow(
          game: game,
          ringer: ringer,
          teamString: 'awayTeam',
          shouldDisplayNotification: shouldDisplayNotification,
        ),
      ],
    );
  }
}

class TeamRow extends StatelessWidget {
  const TeamRow({
    Key key,
    @required this.game,
    @required this.ringer,
    @required this.teamString,
    @required this.shouldDisplayNotification,
  }) : super(key: key);

  final game;
  final Icon ringer;
  final String teamString;
  final bool shouldDisplayNotification;
  bool get isHomeTeam {
    return teamString == 'homeTeam';
  }

  Widget score() {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey[300],
      child: Text(
        isHomeTeam ? "${game['goalsHomeTeam']}" : "${game['goalsAwayTeam']}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (game != null)
          Image.network(
            game[teamString]['logo'],
            height: 20,
          ),
        SizedBox(width: 8),
        Container(
          child: Text(game != null ? game[teamString]['name'] : 'Barcelona'),
          width: 100,
        ),
        Expanded(child: Container()),
        if (game != null) score(),
        SizedBox(width: 8),
        Text('Direct TV'),
        Expanded(child: Container()),
        shouldDisplayNotification && teamString == 'homeTeam'
            ? ringer
            : SizedBox(width: ringer.size),
      ],
    );
  }
}
