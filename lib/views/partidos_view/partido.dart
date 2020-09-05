import 'package:flutter/material.dart';

class Partido extends StatelessWidget {
  final bool displayNotification = false;

  Icon get teamIcon {
    return Icon(Icons.tablet_mac);
  }

  Widget get score {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey[300],
      child: Text(
        '2',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Icon get ringer {
    return Icon(
      Icons.notifications_none,
      size: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            teamIcon,
            SizedBox(width: 8),
            Text('Barcelona'),
            Expanded(child: Container()),
            score,
            SizedBox(width: 8),
            Text('Direct TV'),
            Expanded(child: Container()),
            ringer
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            teamIcon,
            SizedBox(width: 8),
            Text('Barcelona'),
            Expanded(child: Container()),
            score,
            SizedBox(width: 8),
            Text('Direct TV'),
            Expanded(child: Container()),
            SizedBox(width: ringer.size),
          ],
        ),
      ],
    );
  }
}
