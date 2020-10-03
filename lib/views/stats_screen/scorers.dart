import 'package:flutter/material.dart';

class Scorers extends StatelessWidget {
  const Scorers({
    Key key,
    this.homeGoalie,
    this.oppGoalie,
  }) : super(key: key);

  final homeGoalie;
  final oppGoalie;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Goleadores'.toUpperCase(),
            style: TextStyle(color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _playerInfo(true),
              _playerInfo(false),
            ],
          )
        ],
      ),
    );
  }

  Widget _playerInfo(bool isHomeTeam) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            isHomeTeam
                ? '${homeGoalie['urlToImage']}'
                : '${oppGoalie['urlToImage']}',
            width: 100,
          ),
          SizedBox(height: 8),
          Text(isHomeTeam
              ? '${homeGoalie['player_name']}'
              : '${oppGoalie['player_name']}'),
          SizedBox(height: 8),
          // Text('11'),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
