import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
        padding: EdgeInsets.all(8),
        child: Container(
          child: Icon(
            Icons.search,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
