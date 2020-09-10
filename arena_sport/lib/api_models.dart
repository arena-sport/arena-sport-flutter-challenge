typedef giveCountry = void Function(Country c);

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
  final List<LeagueExtra> leagues;

  LeagueResponse({this.resultCount, this.leagues});

  factory LeagueResponse.fromJson(Map<String, dynamic> json) {
    var data = json['api'];
    var list = data['leagues'] as List;

    return LeagueResponse(
      resultCount: data['results'],
      leagues: list.map<LeagueExtra>((j) => LeagueExtra.fromJson(j)).toList(),
    );
  }
}

class League {
  final String name;
  final String country;
  final String logoURL;
  final String flagURL;

  League({
    this.name,
    this.country,
    this.logoURL,
    this.flagURL,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        name: json['name'] as String,
        country: json['country'] as String,
        logoURL: json['logo'] as String,
        flagURL: json['flag'] as String,
      );
}

class LeagueExtra extends League {
  final int leagueID;
  final String type;
  final String countryCode;
  final int season;
  final String seasonStart;
  final String seasonEnd;
  final int standings;
  final int isCurrent;
  final Coverage coverage;

  LeagueExtra({
    this.leagueID,
    String name,
    this.type,
    String country,
    this.countryCode,
    this.season,
    this.seasonStart,
    this.seasonEnd,
    String logoURL,
    String flagURL,
    this.standings,
    this.isCurrent,
    this.coverage,
  }) : super(name: name, country: country, logoURL: logoURL, flagURL: flagURL);

  factory LeagueExtra.fromJson(Map<String, dynamic> json) {
    return LeagueExtra(
      leagueID: json['league_id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      country: json['country'] as String,
      countryCode: json['country_code'] as String,
      season: json['season'] as int,
      seasonStart: json['season_start'] as String,
      seasonEnd: json['season_end'] as String,
      logoURL: json['logo'] as String,
      flagURL: json['flag'] as String,
      standings: json['standings'] as int,
      isCurrent: json['is_current'] as int,
      coverage: Coverage.fromJson(json['coverage']),
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
    this.odds,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      standings: json['standings'] as bool,
      fixtures: Fixtures.fromJson(json['fixtures']),
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

class TeamListResponse {
  final int resultCount;
  final List<TeamExtra> teams;

  TeamListResponse({this.resultCount, this.teams});

  factory TeamListResponse.fromJson(Map<String, dynamic> json) {
    var data = json['api'];
    var list = data['teams'] as List;

    return TeamListResponse(
      resultCount: data['results'] as int,
      teams: list.map<TeamExtra>((e) => TeamExtra.fromJson(e)).toList(),
    );
  }
}

class Team {
  final int teamID;
  final String name;
  final String logoURL;

  Team({
    this.teamID,
    this.name,
    this.logoURL,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamID: json['team_id'] as int,
        name: json['team_name'] as String,
        logoURL: json['logo'] as String,
      );
}

class TeamExtra extends Team {
  final String code;
  final bool isNational;
  final String country;
  final int founded;
  final String venueName;
  final String venueSurface;
  final String venueAddress;
  final String venueCity;
  final int venueCapacity;

  TeamExtra({
    int teamID,
    String name,
    this.code,
    String logoURL,
    this.isNational,
    this.country,
    this.founded,
    this.venueName,
    this.venueSurface,
    this.venueAddress,
    this.venueCity,
    this.venueCapacity,
  }) : super(teamID: teamID, name: name, logoURL: logoURL);

  factory TeamExtra.fromJson(Map<String, dynamic> json) {
    return TeamExtra(
      teamID: json['team_id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      logoURL: json['logo'] as String,
      isNational: json['is_national'] as bool,
      country: json['country'] as String,
      founded: json['founded'] as int,
      venueName: json['venue_name'] as String,
      venueSurface: json['venue_surface'] as String,
      venueAddress: json['venue_address'] as String,
      venueCity: json['venue_city'] as String,
      venueCapacity: json['venue_capacity'] as int,
    );
  }
}

class Fixture {
  final int fixtureID;
  final int leagueID;
  final League league;
  final String eventDate;
  final int eventTimestamp;
  final int firstHalfStart;
  final int secondHalfStart;
  final String round;
  final String status;
  final String statusShort;
  final int elapsed;
  final String venue;
  final String referee;
  final Team homeTeam;
  final Team awayTeam;
  final int goalsHomeTeam;
  final int goalsAwayTeam;
  final Score score;

  Fixture({
    this.fixtureID,
    this.leagueID,
    this.league,
    this.eventDate,
    this.eventTimestamp,
    this.firstHalfStart,
    this.secondHalfStart,
    this.round,
    this.status,
    this.statusShort,
    this.elapsed,
    this.venue,
    this.referee,
    this.homeTeam,
    this.awayTeam,
    this.goalsHomeTeam,
    this.goalsAwayTeam,
    this.score,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        fixtureID: json['fixture_id'] as int,
        leagueID: json['league_id'] as int,
        league: League.fromJson(json['league']),
        eventDate: json['event_date'] as String,
        eventTimestamp: json['event_timestamp'] as int,
        firstHalfStart: json['firstHalfStart'] as int,
        secondHalfStart: json['secondHalfStart'] as int,
        round: json['round'] as String,
        status: json['status'] as String,
        statusShort: json['statusShort'] as String,
        elapsed: json['elapsed'] as int,
        venue: json['venue'] as String,
        referee: json['referee'] as String,
        homeTeam: Team.fromJson(json['homeTeam']),
        awayTeam: Team.fromJson(json['awayTeam']),
        goalsHomeTeam: json['goalsHomeTeam'] as int,
        goalsAwayTeam: json['goalsAwayTeam'] as int,
        score: Score.fromJson(json['score']),
      );
}

class Score {
  final String halftime;
  final String fullTime;
  final String extraTime;
  final String penalty;

  Score({
    this.halftime,
    this.fullTime,
    this.extraTime,
    this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        halftime: json['halftime'] as String,
        fullTime: json['fulltime'] as String,
        extraTime: json['extratime'] as String,
        penalty: json['penalty'] as String,
      );
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
