import 'package:arena_sport/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'api_models.dart';
import 'models.dart';

class StatsPage extends StatelessWidget {
  final List<String> navButton = [
    'Info',
    'Estadisticas',
    'Formacion',
    'H2H',
    'Tracker'
  ];

  StatsPage() {
    if (StatsPageModel.model.bNavIndex == null) {
      StatsPageModel.model.bNavIndex = 0;
    }
  }

  // Calling causes page to go directly to H2H tab
  // And show the details for the provided fixture
  factory StatsPage.toH2H(Fixture fixture) {
    StatsPageModel.model.bNavIndex = 3;
    StatsPageModel.model.h2hFixture = fixture;

    return StatsPage();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: StatsPageModel.model,
        child: Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ScopedModelDescendant<StatsPageModel>(
                builder: (context, child, model) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 12.0),
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: navButton
                          .map<Widget>((title) => Expanded(
                                child: FlatButton(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        color: navButton.indexOf(title) ==
                                                model.bNavIndex
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  onPressed: () {
                                    StatsPageModel.model.bNavIndex =
                                        navButton.indexOf(title);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
              ScopedModelDescendant<StatsPageModel>(
                builder: (context, child, model) {
                  switch (model.bNavIndex) {
                    case 0:
                    case 1:
                    case 2:
                    case 4:
                      return Container();
                    case 3:
                      return _H2H();
                    default:
                      throw Exception('Stats page bNavIndex out of bounds.');
                  }
                },
              ),
            ],
          ),
        ));
  }
}

class StatsPageModel extends Model {
  static StatsPageModel _model;

  static StatsPageModel of(BuildContext context) =>
      ScopedModel.of<StatsPageModel>(context);

  StatsPageModel();

  // Get model
  // If _model is null, new model is instantiated and set to model and returned.
  static StatsPageModel get model =>
      // If null, instantiate a new StatsPageModel
      _model ??
      () {
        _model = StatsPageModel();
        return _model;
      }();

  // Keep just in case moment comes where model needs to be refreshed
  // static void newModel() => _model = StatsPageModel();

  int _bNavIndex;
  Fixture _h2hFixture;
  ModelMap<int, List<Standings>> _standings;

  int get bNavIndex => _bNavIndex;
  set bNavIndex(int newIndex) {
    // Do nothing if value is the same
    if (_bNavIndex == newIndex) {
      return;
    }

    _bNavIndex = newIndex;
    notifyListeners();
  }

  Fixture get h2hFixture => _h2hFixture;
  set h2hFixture(Fixture fixture) {
    // Do nothing if value is the same
    if (_h2hFixture == fixture) {
      return;
    }

    _h2hFixture = fixture;
    notifyListeners();
  }

  ModelMap<int, List<Standings>> get standings =>
      _standings ?? ModelMap<int, List<Standings>>(this.notifyListeners);

  Future<Standings> get h2hHomeStanding async =>
      standings.containsKey(_h2hFixture.leagueID)
          ? standings[_h2hFixture.leagueID]
              .singleWhere((team) => team.teamID == _h2hFixture.homeTeam.teamID)
          : getLeagueStandings(_h2hFixture.leagueID).then((leagueStandings) {
              _standings[_h2hFixture.leagueID] = leagueStandings;
              return leagueStandings.singleWhere(
                  (team) => team.teamID == _h2hFixture.homeTeam.teamID);
            });

  Future<Standings> get h2hAwayStanding async =>
      standings.containsKey(_h2hFixture.leagueID)
          ? standings[_h2hFixture.leagueID]
              .singleWhere((team) => team.teamID == _h2hFixture.awayTeam.teamID)
          : getLeagueStandings(_h2hFixture.leagueID).then((leagueStandings) {
              _standings[_h2hFixture.leagueID] = leagueStandings;
              return leagueStandings.singleWhere(
                  (team) => team.teamID == _h2hFixture.awayTeam.teamID);
            });
}

class _H2H extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (StatsPageModel.model.h2hFixture == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              padding: EdgeInsets.all(4.0),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              getTeamLogo(StatsPageModel
                                  .model.h2hFixture.homeTeam.logoURL),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [Text('POSICION EN LIGA')],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder<Standings>(
                                    future:
                                        StatsPageModel.model.h2hHomeStanding,
                                    builder: (context, snapshot) =>
                                        snapshot.hasData
                                            ? Text('${snapshot.data.rank}')
                                            : Container(),
                                  ),
                                  FutureBuilder<Standings>(
                                    future:
                                        StatsPageModel.model.h2hAwayStanding,
                                    builder: (context, snapshot) =>
                                        snapshot.hasData
                                            ? Text('${snapshot.data.rank}')
                                            : Container(),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              getTeamLogo(StatsPageModel
                                  .model.h2hFixture.awayTeam.logoURL),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [Text('ENCUENTROS PREVIOS')],
                      ),
                      Row(
                        children: [
                          Column(),
                          Column(
                            children: [Text('')],
                          ),
                          Column(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
