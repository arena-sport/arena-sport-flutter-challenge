import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models.dart';

class HomePage extends StatefulWidget {
  HomePage(this.model, {Key key}) : super(key: key);

  final HomePageModel model;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomePageModel>(
      model: widget.model,
      child: Center(
        child: ListView(
          children: [
            _TeamViewWidget(),
          ],
        ),
      ),
    );
  }
}

class _TeamViewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageModel>(
      builder: (context, child, model) {
        return ListView(
          children: [],
          scrollDirection: Axis.horizontal,
        );;
      },
    );
  }
}