import 'package:arena_sport/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

// DISCLAIMER: This will only show the teams of the first league in the country
// There is no way yet to select different leagues to follow
// Therefore only the first league will be presented to the end user
// This will be changed in the future
// TODO Change functionality
class _TeamViewWidget extends StatelessWidget {
  _TeamViewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomePageModel>(
      builder: (context, child, model) {
        return ListView(
          children: model.teamsFollowing.map<Widget>((team) => IconButton(
                icon: getTeamLogo(team),
                onPressed: () {
                  // TODO When team is selected from list
                },
              )),
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }
}

class _UpcomingGamesCard extends StatefulWidget {
  final LeagueExtra league;

  _UpcomingGamesCard(this.league, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpcomingGamesCardState();
}

class _UpcomingGamesCardState extends State<_UpcomingGamesCard> {
  Future<List<Fixture>> fixtures;

  @override
  void initState() {
    fixtures = getFixturesFromLeague(widget.league.leagueID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Partidos'),
              FlatButton(
                  onPressed: () {
                    // TODO implement Ver todos button functionality
                  },
                  child: Text('Ver todos'))
            ],
          ),
          Divider(),
          Text(widget.league.name),
        ],
      ),
    );
  }
}
