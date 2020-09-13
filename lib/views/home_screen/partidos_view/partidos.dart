import 'package:flutter/material.dart';
import 'package:arena/widgets/styled_card.dart';
import './partido.dart';

class Partidos extends StatelessWidget {
  Partidos({this.games});
  final List<dynamic> games;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      title: 'Partidos',
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UEFA Champions League",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                bool shouldDisplayNotification = index == 0;
                return Partido(
                  shouldDisplayNotification: shouldDisplayNotification,
                  game: games != null ? games[index] : [],
                );
              },
              itemCount: 3,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
