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
  List<League> _leagues;

  Country get country => _country;

  List<League> get leagues => _leagues;

  void setUserCountry(Country country) {
    _country = country;

    notifyListeners();
  }

  void setUserLeagues(List<League> leagues) {
    _leagues = leagues;

    notifyListeners();
  }
}

// used to retrieve data from country api
class CountryResponse {

  final int results;
  final List<Country> countries;

  CountryResponse({this.results, this.countries});

  factory CountryResponse.fromJson(Map<String, dynamic> json) {

    var data = json['api'];
    var list = data['countries'] as List;

    return CountryResponse(
      results: data['results'] as int,
      countries: list.map<Country>((j) => Country.fromJson(j)).toList(),
    );
  }
}

// class for storing country data coming from api
class Country {
  final String country;
  final String code;
  final String flagUrl;

  Country({this.country, this.code, this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['country'] as String,
      code: json['code'] as String,
      flagUrl: json['flag'] as String,
    );
  }
}

class LeagueResponse {
  final int resultCount;
  final List<League> leagues;

  LeagueResponse({this.resultCount, this.leagues});

  factory LeagueResponse.fromJson(Map<String, dynamic> json) {

    var data = json['api'];
    var list = json['leagues'] as List;

    return LeagueResponse(
      resultCount: data['results'],
      leagues: list.map<League>((j) => League.fromJson(j)).toList(),
    );
  }
}

class League {
  final int leagueId;
  final String name;
  final String type;
  final String country;
  final String countryCode;
  final int season;
  final String seasonStart;
  final String seasonEnd;
  final String logoUrl;
  final String flagImageUrl;
  final int standings;
  final int isCurrent;
  final Coverage coverage;

  League({
    this.leagueId,
    this.name,
    this.type,
    this.country,
    this.countryCode,
    this.season,
    this.seasonStart,
    this.seasonEnd,
    this.logoUrl,
    this.flagImageUrl,
    this.standings,
    this.isCurrent,
    this.coverage,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueId: json['league_id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      country: json['country'] as String,
      countryCode: json['country_code'] as String,
      season: json['season'] as int,
      seasonStart: json['season_start'] as String,
      seasonEnd: json['season_end'] as String,
      logoUrl: json['logo'] as String,
      flagImageUrl: json['flag'] as String,
      standings: json['standings'] as int,
      isCurrent: json['is_current'] as int,
      coverage: json['coverage'] as Coverage,
    );
  }
}

class Coverage {
  final bool standings;
  final Fixtures fixtures;
  final bool players;
  final bool topScorers;
  final bool predictions;
  final bool odds;

  Coverage({
  this.standings,
  this.fixtures,
  this.players,
  this.topScorers,
  this.predictions,
  this.odds,});

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      standings: json['standings'] as bool,
      fixtures: json['fixtures'] as Fixtures,
      players: json['players'] as bool,
      topScorers: json['topScorers'] as bool,
      predictions: json['predictions'] as bool,
      odds: json['odds'] as bool,
    );
  }
}

class Fixtures {
  final bool events;
  final bool lineups;
  final bool stats;
  final bool playersStats;

  Fixtures({this.events, this.lineups, this.stats, this.playersStats});

  factory Fixtures.fromJson(Map<String, dynamic> json) {
    return Fixtures(
      events: json['events'] as bool,
      lineups: json['lineups'] as bool,
      stats: json['statistics'] as bool,
      playersStats: json['players_statistics'] as bool,
    );
  }
}

////////////////////////////////////////////////////
// Home Page Model
////////////////////////////////////////////////////

class HomePageModel extends Model {

}