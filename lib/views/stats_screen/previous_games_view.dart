import 'package:flutter/material.dart';

import 'package:arena/widgets/previous_game.dart';

class PreviousGamesView extends StatelessWidget {
  const PreviousGamesView({
    Key key,
  }) : super(key: key);

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
                  children: [
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                    PreviousGame(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
