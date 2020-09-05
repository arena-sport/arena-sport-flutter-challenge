import 'package:flutter/material.dart';

class TeamsListView extends StatelessWidget {
  const TeamsListView({
    Key key,
  }) : super(key: key);

  static const teamLogos = [
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
    'https://www.jetpunk.com/img/user-photo-library/24/245b108023-450.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Image.network(teamLogos[index]),
            margin: EdgeInsets.symmetric(horizontal: 8),
          );
        },
        itemCount: teamLogos.length,
      ),
    );
  }
}
