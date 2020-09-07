import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

////////////////////////////////////////////////////
// Getters
////////////////////////////////////////////////////

Future<List<Country>> getCountriesList() async {
  var response = await http.get(
    // api url to get list of countries supported by api
    "https://api-football-v1.p.rapidapi.com/v2/countries",
    headers: {
      // TODO Get API key and fill here
      'X-RapidAPI-Key': 'XXXXXXXXXXXXXXXXXXXXXXXXX',
    },
  );

  if (response.statusCode == 200) {
    // If returns 200 OK response
    // Then return the list of countries
    return CountryResponse.fromJson(json.decode(response.body)).countries;
  } else {
    // Not OK
    throw Exception('Failed to load countries');
  }
}

Future<List<League>> getLeaguesInCountry(Country country) async {
  return await http.get(
    'https://api-football-v1.p.rapidapi.com/v2/leagues/country/${country.code}',
    headers: {
      // TODO Get API key and fill here
      'X-RapidAPI-Key': 'XXXXXXXXXXXXXXXXXXXXXXXXX',
    },
  ).then((response) {
    if (response.statusCode == 200) {
      return LeagueResponse.fromJson(json.decode(response.body)).leagues;
    } else {
      throw Exception('Failed to load leagues');
    }
  }).catchError(print);
}

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
      cacheWidth: width,
      cacheHeight: height,
      headers: headers.isEmpty ? null : headers,
    );
