import 'package:flutter/material.dart';

class PreviousGame extends StatelessWidget {
  const PreviousGame({
    Key key,
  }) : super(key: key);

  Text get _flagText {
    return Text(
      'G',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget get _previousGame {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: _flagText,
      ),
    );
  }

  Widget get _label {
    return Text(
      'vs Team Name 0:0',
      style: TextStyle(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          _previousGame,
          SizedBox(width: 8),
          _label,
        ],
      ),
    );
  }
}
