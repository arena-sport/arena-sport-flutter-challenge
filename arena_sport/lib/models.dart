import 'dart:collection';

import 'api_models.dart';

import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;

    notifyListeners();
  }
}

////////////////////////////////////////////////////
// User Info Model
////////////////////////////////////////////////////

class UserInfoModel extends Model {
  Country _country;
  List<LeagueExtra> _leagues;
  bool _isLive;

  // Getters
  Country get country => _country;
  List<LeagueExtra> get leagues => _leagues;
  bool get isLive => _isLive;

  void setUserCountry(Country country) {
    _country = country;

    notifyListeners();
  }

  void setUserLeagues(List<LeagueExtra> leagues) {
    _leagues = leagues;

    notifyListeners();
  }

  void setIsLive(bool newIsLive) {
    _isLive = newIsLive;

    notifyListeners();
  }
}

////////////////////////////////////////////////////
// Home Page Model
////////////////////////////////////////////////////

class HomePageModel extends Model {
  HashSet<TeamExtra> _teamsFollowing;
  HashSet<LeagueExtra> _leaguesFollowing;

  // Getters
  // HashSet<TeamExtra> get teamsFollowing => _teamsFollowing;
  // HashSet<LeagueExtra> get leaguesFollowing => _leaguesFollowing;

  // Adds team to the set.
  // Returns true if team (or an equal value) was not yet in the set.
  // Otherwise returns false and the set is not changed.
  bool addTeam(TeamExtra team) {
    var b = _teamsFollowing.add(team);

    notifyListeners();

    return b;
  }

  // Adds teams to the set.
  void addTeams(List<TeamExtra> teams) {
    _teamsFollowing.addAll(teams);

    notifyListeners();
  }

  // Removes teams from the set.
  // Returns true if team was in the set. Returns false otherwise.
  // The method has no effect if team value was not in the set.
  bool removeTeam(TeamExtra team) {
    var b = _teamsFollowing.remove(team);

    notifyListeners();

    return b;
  }

  // Removes teams from the set.
  void removeTeams(List<TeamExtra> teams) {
    _teamsFollowing.removeAll(teams);

    notifyListeners();
  }

  // Returns true if team is in the set.
  bool containsTeam(TeamExtra team) {
    return _teamsFollowing.contains(team);
  }

  Iterable<T> mapTeams<T>(T f(Team t)) {
    return _teamsFollowing.map<T>(f);
  }

  // Adds league to the set.
  // Returns true if league (or equivalent value) was not yet in the set.
  // Otherwise returns false and the set is not changed.
  bool addLeague(LeagueExtra league) {
    var b = _leaguesFollowing.add(league);

    notifyListeners();

    return b;
  }

  // Adds leagues to the set.
  void addLeagues(List<LeagueExtra> leagues) {
    _leaguesFollowing.addAll(leagues);

    notifyListeners();
  }

  // Removes leagues from the set.
  // Returns true if team was in the set. Returns false otherwise.
  // The method has no effect if league value was not in the set.
  bool removeLeague(LeagueExtra league) {
    var b = _leaguesFollowing.remove(league);

    notifyListeners();

    return b;
  }

  // Removes leagues from the set.
  void removeLeagues(List<LeagueExtra> leagues) {
    _leaguesFollowing.removeAll(leagues);

    notifyListeners();
  }

  // Returns true if league is in the set.
  bool containsLeague(LeagueExtra league) {
    return _leaguesFollowing.contains(league);
  }

  Iterable<T> mapLeagues<T>(T f(League l)) {
    return _leaguesFollowing.map<T>(f);
  }
}

class FixtureResponse {
  final int resultCount;
  final List<Fixture> fixtures;

  FixtureResponse({
    this.resultCount,
    this.fixtures,
  });

  factory FixtureResponse.fromJson(Map<String, dynamic> json) {
    var data = json['api'];
    var list = data['fixtures'];

    return FixtureResponse(
      resultCount: data['results'],
      fixtures: list.map<Fixture>((json) => Fixture.fromJson(json)).toList(),
    );
  }
}

