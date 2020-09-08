import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'api_models.dart';
import 'models.dart';

const API_FOOTBALL_HEADERS = {
  'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
  'X-RapidAPI-Key': 'c0a29c1cddmsh2ba773d3125f18cp1e152djsnfac76f984e8d',
};

////////////////////////////////////////////////////
// Getters
////////////////////////////////////////////////////

Future<List<Country>> getCountriesList() => http
    .get(
      // api url to get list of countries supported by api
      "https://api-football-v1.p.rapidapi.com/v2/countries",
      headers: API_FOOTBALL_HEADERS,
    )
    .then((response) => response.statusCode == 200
        ? CountryResponse.fromJson(json.decode(response.body)).countries
        : throw Exception('Failed to load countries.'))
    .catchError(print);

Future<List<LeagueExtra>> getLeaguesInCountry(Country country) => http
    .get(
      'https://api-football-v1.p.rapidapi.com/v2/leagues/country/${country.code}',
      headers: API_FOOTBALL_HEADERS,
    )
    .then((response) => response.statusCode == 200
        ? LeagueResponse.fromJson(json.decode(response.body)).leagues
        : throw Exception('Failed to load leagues.'))
    .catchError(print);

Future<List<TeamExtra>> getTeamsInLeague(int leagueID) => http
    .get(
      'https://api-football-v1.p.rapidapi.com/v2/teams/league/$leagueID',
      headers: API_FOOTBALL_HEADERS,
    )
    .then((response) => response.statusCode == 200
        ? TeamListResponse.fromJson(json.decode(response.body)).teams
        : throw Exception('Failed to load teams.'))
    .catchError(print);

// Get fixtures for leagueID
Future<List<Fixture>> getFixturesFromLeague(int leagueID) => http
    .get('https://api-football-v1.p.rapidapi.com/v2/fixtures/league/$leagueID',
        headers: API_FOOTBALL_HEADERS)
    .then((response) => response.statusCode == 200
        ? FixtureResponse.fromJson(json.decode(response.body)).fixtures
        : throw Exception('Failed to load fixtures from league.'))
    .catchError(print);

Image getTeamLogo(TeamExtra team) => _getImageFromURL(team.logoURL,
    width: 16, height: 16, headers: API_FOOTBALL_HEADERS);

Image getCountryImage(Country country) => _getImageFromURL(
      country.flagUrl,
      width: 24,
      height: 24,
      headers: API_FOOTBALL_HEADERS,
    );

Image _getImageFromURL(String url,
        {int width, int height, Map<String, String> headers}) =>
    Image.network(
      url,
      cacheWidth: width == 0 ? null : width,
      cacheHeight: height == 0 ? null : height,
      headers: headers.isEmpty ? null : headers,
    );
