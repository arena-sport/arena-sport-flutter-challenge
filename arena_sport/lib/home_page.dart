import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ListView(
        children: [
          _TeamViewWidget(),
        ],
      ),
    );
  }
}

class _TeamViewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
      scrollDirection: Axis.horizontal,
    );
  }
}