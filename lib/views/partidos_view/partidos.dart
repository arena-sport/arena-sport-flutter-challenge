import 'package:flutter/material.dart';
import './partido.dart';

class Partidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "UEFA Champions League",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return Partido();
              // print('hello');
              // return Container(
              //   child: Text('32'),
              //   height: 40,
              //   // width: 20,
              // );
            },
            itemCount: 3,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }
}
