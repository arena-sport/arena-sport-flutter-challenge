import 'package:flutter/material.dart';

class ComparisonView extends StatelessWidget {
  final List<dynamic> comparison;
  ComparisonView({this.comparison});

  Widget _teamLogo(int which) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          child: comparison != null
              ? Image.network(comparison[which]['logo'])
              : null,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _teamLogoColumn(int which) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _teamLogo(which),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _teamLogoColumn(0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Position in League'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 'Position in League'.length * 8.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: comparison != null
                          ? [
                              Text('${comparison[0]['rank']}'),
                              Text('${comparison[1]['rank']}')
                            ]
                          : null,
                    ),
                  ),
                  Text(
                    'Encuentros Previos'.toUpperCase(),
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    '13 Empates'.toUpperCase(),
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              _teamLogoColumn(1),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
