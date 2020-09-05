import 'package:flutter/material.dart';

class Game {
  final String homeTeam;
  final String oppTeam;
  final Icon homeIcon;
  final Icon oppIcon;
  final int homeScore;
  final int oppScore;
  Game({
    @required this.homeTeam,
    @required this.oppTeam,
    this.homeIcon,
    this.oppIcon,
    @required this.homeScore,
    @required this.oppScore,
  });
}
