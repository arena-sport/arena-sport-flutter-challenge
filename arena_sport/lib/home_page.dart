import 'package:arena_sport/api.dart';
import 'api_models.dart';

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
      child: Container(
        color: Colors.grey[200],
        child: Center(
          child: ScopedModelDescendant<HomePageModel>(
            builder: (context, child, model) {
              return ListView(
                children: [
                  _TeamViewWidget(),
                  ...widget.model.leaguesFollowing
                      .map<Widget>((league) =>
                          _UpcomingGamesCard(league, key: UniqueKey()))
                      .toList(),
                ],
              );
            },
          ),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(4.0),
      color: Colors.white,
      height: 54.0,
      child: ScopedModelDescendant<HomePageModel>(
        builder: (BuildContext context, Widget child, HomePageModel model) {
          if (model.teamsFollowing.length == 0) {
            return FutureBuilder(
                future: getTeamsInLeague(model.leaguesFollowing.first.leagueID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data.map<Widget>((team) {
                        return GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: getTeamLogo(team.logoURL),
                          ),
                          // TODO Implement tapping on teams to bring up team stats
                          onTap: () {},
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {}

                  return Container();
                });
          }

          return ListView(
            scrollDirection: Axis.horizontal,
            children: model.mapTeams<Widget>((team) => IconButton(
                  icon: getTeamLogo(team.logoURL),
                  onPressed: () {
                    // TODO When team is selected from list
                  },
                )),
            // scrollDirection: Axis.horizontal,
          );
        },
      ),
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
  Future<List<Fixture>> _fixtures;

  @override
  void initState() {
    _fixtures = getFixturesFromLeague(widget.league.leagueID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PARTIDOS',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                    onPressed: () {
                      // TODO implement Ver todos button functionality
                    },
                    child: Text(
                      'Ver todos',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.league.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
                  ),
                )
              ],
            ),
            FutureBuilder(
                future: _fixtures,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int count = 0;

                    return Table(
                      border: TableBorder(
                        horizontalInside:
                            BorderSide(width: 0.4, color: Colors.grey[300]),
                      ),
                      children: snapshot.data.where((Fixture fixture) {
                        // Only show 3 fixtures max
                        if (count >= 3) {
                          return false;
                        }

                        count++;

                        return true;
                      }).map<TableRow>((fixture) {
                        return TableRow(
                          children: [
                            _FixtureTile(fixture),
                          ],
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('ERROR'),
                    );
                  }

                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}

class _FixtureTile extends StatelessWidget {
  final Fixture _fixture;

  _FixtureTile(this._fixture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: <int, TableColumnWidth>{
            0: const FixedColumnWidth(36.0), // Team Logo
            1: const FractionColumnWidth(0.5), // Team name
            2: const FixedColumnWidth(16.0), // Team score
            3: null, // Time in game or where game is available
            4: const FixedColumnWidth(
                24.0), // Bell icon (if game is still going) or nothing
          },
          children: [
            TableRow(
              children: <Widget>[
                getTeamLogo(_fixture.homeTeam.logoURL),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    _fixture.homeTeam.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(3.0, 2.0, 2.0, 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey[200],
                  ),
                  child: Text(
                    '${_fixture.goalsHomeTeam}',
                    style: TextStyle(
                      letterSpacing: 0.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${_fixture.statusShort == 'FT' ? 'Terminado' : _fixture.elapsed}',
                    style: TextStyle(
                      color: _fixture.statusShort == 'FT'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
                _fixture.statusShort == 'FT'
                    ? Container()
                    : IconButton(
                        // TODO implement button to sign up for notifications for the game
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Colors.grey[300],
                        ),
                        onPressed: () {},
                      ),
              ],
            ),
            TableRow(
              children: <Widget>[
                getTeamLogo(_fixture.awayTeam.logoURL),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    _fixture.awayTeam.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(3.0, 2.0, 2.0, 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey[200],
                  ),
                  child: Text(
                    '${_fixture.goalsAwayTeam}',
                    style: TextStyle(
                      letterSpacing: 0.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(),
                ),
                Container(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
