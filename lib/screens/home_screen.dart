import 'package:flutter/material.dart';

import 'package:arena/views/home_screen/noticias_view/noticias.dart';
import 'package:arena/views/home_screen/partidos_view/partidos.dart';
import 'package:arena/views/home_screen/teams_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 8),
          TeamsListView(),
          Partidos(),
          Noticias(),
          SizedBox(height: 8),
          Partidos(),
        ],
      ),
    );
  }
}
