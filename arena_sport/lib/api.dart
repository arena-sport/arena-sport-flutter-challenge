import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

////////////////////////////////////////////////////
// Getters
////////////////////////////////////////////////////

Future<List<Country>> getCountriesList() => http
    .get(
      // api url to get list of countries supported by api
      "https://api-football-v1.p.rapidapi.com/v2/countries",
      headers: {
        // TODO Get API key and fill here
        'X-RapidAPI-Key': 'XXXXXXXXXXXXXXXXXXXXXXXXX',
      },
    )
    .then((response) => response.statusCode == 200
        ? CountryResponse.fromJson(json.decode(response.body)).countries
        : throw Exception('Failed to load countries.'))
    .catchError(print);

Future<List<League>> getLeaguesInCountry(Country country) => http
    .get(
      'https://api-football-v1.p.rapidapi.com/v2/leagues/country/${country.code}',
      headers: {
        // TODO Get API key and fill here
        'X-RapidAPI-Key': 'XXXXXXXXXXXXXXXXXXXXXXXXX',
      },
    )
    .then((response) => response.statusCode == 200
        ? LeagueResponse.fromJson(json.decode(response.body)).leagues
        : throw Exception('Failed to load leagues.'))
    .catchError(print);

Image getCountryImage(Country country) => _getImageFromURL(
      country.flagUrl,
      width: 16,
      height: 16,
      headers: {
        // TODO Get API key and fill here
        'X-RapidAPI-Key': 'XXXXXXXXXXXXXXXXXXXXXXXXX',
      },
    );

Image _getImageFromURL(String url,
        {int width, int height, Map<String, String> headers}) =>
    Image.network(
      url,
      cacheWidth: width == 0 ? null : width,
      cacheHeight: height == 0 ? null : height,
      headers: headers.isEmpty ? null : headers,
    );
