import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GoalAverages extends StatelessWidget {
  final List<charts.Series> seriesList = [
    charts.Series<int, int>(
      id: 'Goal avg',
      domainFn: (datum, index) {
        return datum;
      },
      measureFn: (datum, index) {
        return datum;
      },
      data: [1, 2],
    ),
  ];
  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'promedio de goles'.toUpperCase(),
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Container(
                  child: charts.PieChart(
                    seriesList,
                    animate: true,
                    defaultRenderer: charts.ArcRendererConfig(arcWidth: 6),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: charts.PieChart(
                    seriesList,
                    animate: true,
                    defaultRenderer: charts.ArcRendererConfig(arcWidth: 6),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
