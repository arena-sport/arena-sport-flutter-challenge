import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final Widget child;
  final String title;

  const StyledCard({
    this.child,
    this.title,
    Key key,
  }) : super(key: key);

  Widget _getHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ver Todos',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        Container(
          color: Colors.grey.withOpacity(0.2),
          height: 1,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        child
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        // height: 200,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            _getHeader(),
          ],
        ),
      ),
    );
  }
}
