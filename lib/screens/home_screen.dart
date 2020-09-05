import 'package:flutter/material.dart';

import 'package:arena/views/partidos_view/partidos.dart';
import 'package:arena/views/teams_list_view/teams_list_view.dart';
import 'package:arena/views/noticias_view/noticias.dart';

import 'package:arena/widgets/styled_bottom_navigation_bar.dart';
import 'package:arena/widgets/styled_app_bar.dart';

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
