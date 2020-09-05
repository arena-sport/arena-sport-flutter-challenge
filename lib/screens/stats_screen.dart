import 'package:arena/views/horizontal_list_views/information_list_view.dart';
import 'package:flutter/material.dart';

import '../views/horizontal_list_views/information_list_view.dart';
import '../views/comparison_view/comparison_view.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationListView(),
        ComparisonView(),
      ],
    );
  }
}
