import 'package:flutter/material.dart';
import 'circle_button.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  StyledAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(_appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return _appBar;
  }

  final _appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Row(
      children: [
        Text(
          "ARENA",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Expanded(child: Container()),
        Text(
          'Live',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Switch.adaptive(value: false, onChanged: (_) => {}),
        CircleButton()
      ],
    ),
  );
}
