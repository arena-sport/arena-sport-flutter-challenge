import 'package:flutter/material.dart';

class Scorers extends StatelessWidget {
  const Scorers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      child: Column(
        children: [
          Text(
            'Goleadores'.toUpperCase(),
            style: TextStyle(color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _playerInfo(),
              _playerInfo(),
            ],
          )
        ],
      ),
    );
  }

  Widget _playerInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/player_face.jpg',
            width: 50,
          ),
          SizedBox(height: 8),
          Text('Player Name'),
          SizedBox(height: 8),
          Text('11'),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
