import 'package:flutter/material.dart';

class InformationListView extends StatelessWidget {
  const InformationListView({
    Key key,
  }) : super(key: key);

  static const selectableInformation = [
    'Info',
    'Statistics',
    'Lineup',
    'H2H',
    'Tracker'
  ];

  final indexSelected = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: selectableInformation
            .asMap()
            .map((index, labelText) {
              final label = Container(
                alignment: Alignment.center,
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: indexSelected == index ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 8),
              );

              return MapEntry(index, label);
            })
            .values
            .toList(),
      ),
    );
  }
}
