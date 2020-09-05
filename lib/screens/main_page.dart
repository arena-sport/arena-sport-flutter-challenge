import 'package:flutter/material.dart';
import 'package:arena/views/partidos_view/partidos.dart';
import 'package:arena/widgets/styled_card.dart';
import 'package:arena/widgets/styled_app_bar.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: StyledAppBar(),
      body: Column(
        children: [
          SizedBox(height: 8),
          Container(
            color: Colors.red,
            height: 60,
          ),
          StyledCard(
            child: Partidos(),
          )
        ],
      ),
    );
  }
}
