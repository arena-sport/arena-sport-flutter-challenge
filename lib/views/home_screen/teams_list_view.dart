import 'package:flutter/material.dart';

class TeamsListView extends StatelessWidget {
  const TeamsListView({
    this.teams,
    Key key,
  }) : super(key: key);

  final List<dynamic> teams;

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
            child: Image.network(teams[index]['logo']),
            margin: EdgeInsets.symmetric(horizontal: 8),
          );
        },
        itemCount: teams.length,
      ),
    );
  }
}
