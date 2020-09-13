import 'dart:async';
import 'dart:convert';

import 'package:arena_sport/config.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'api_models.dart';

const API_FOOTBALL_HEADERS = {
  'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
  'X-RapidAPI-Key': API_KEY,
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

Future<List<LeagueExtra>> searchLeagues(String text) => http
    .get(
      'https://api-football-v1.p.rapidapi.com/v2/leagues/search/${text.trim().replaceAll(RegExp(' '), '_')}',
      headers: API_FOOTBALL_HEADERS,
    )
    .then((response) => response.statusCode == 200
        ? LeagueResponse.fromJson(json.decode(response.body)).leagues
        : throw Exception('Failed to load search results.'))
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

Future<List<Standings>> getLeagueStandings(int leagueID) => http
    .get(
      'https://api-football-v1.p.rapidapi.com/v2/leagueTable/$leagueID',
      headers: API_FOOTBALL_HEADERS,
    )
    .then((response) => response.statusCode == 200
        ? StandingsResponse.fromJson(json.decode(response.body)).standings
        : throw Exception('Failed to load standings.'))
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

Image getLeagueLogo(LeagueExtra league) =>
    _getImageFromURL(league.logoURL, width: 48, headers: API_FOOTBALL_HEADERS);

Image getTeamLogo(String url) =>
    _getImageFromURL(url, width: 64, height: 64, headers: API_FOOTBALL_HEADERS);

Image getCountryImage(Country country) => _getImageFromURL(
      country.flagUrl,
      width: 32,
      height: 32,
      headers: API_FOOTBALL_HEADERS,
    );

// TODO Find way to catch exceptions thrown when image cannot be retrieved
Image _getImageFromURL(String url,
        {int width, int height, Map<String, String> headers}) =>
    Image.network(
      url,
      cacheWidth: width == 0 ? null : width,
      cacheHeight: height == 0 ? null : height,
      headers: headers.isEmpty ? null : headers,
    );
