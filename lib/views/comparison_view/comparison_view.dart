import 'package:flutter/material.dart';

class ComparisonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.green,
                height: 50,
                width: 50,
              ),
              SizedBox(height: 8),
            ],
          ),
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
                  children: [Text('3'), Text('7')],
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.red,
                height: 50,
                width: 50,
              ),
              SizedBox(height: 8),
            ],
          )
        ],
      ),
    );
  }
}
