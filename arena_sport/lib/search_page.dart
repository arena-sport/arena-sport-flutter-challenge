import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_models.dart';
import 'api.dart' as api;

import 'dart:async';

class SearchPage extends StatefulWidget {
  final HashSet<LeagueExtra> currentlyFollowing;

  SearchPage(this.currentlyFollowing);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController;
  FocusNode _searchFocusNode;

  HashSet<LeagueExtra> following;
  Future<List<LeagueExtra>> _leagues;

  @override
  void initState() {
    super.initState();

    following = widget.currentlyFollowing ?? HashSet<League>();

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  Future<List<LeagueExtra>> searchLeagues(String search) =>
      api.searchLeagues(search).then((response) {
        response.removeWhere((league) => league.season != 2020);
        return response;
      });

  Widget _displayResults(List<LeagueExtra> leagues) {
    // TODO insert stateful builder here to reduce the need of rebuilding entire listview when user choices are made
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: leagues.length,
        itemBuilder: (BuildContext context, int index) {
          var currLeague = leagues[index];
          return ListTile(
            leading: api.getLeagueLogo(currLeague),
            title: Text(currLeague.name),
            trailing: following.contains(currLeague)
                ? Text(
                    'FOLLOWING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  )
                : null,
            onTap: () {
              setState(() {
                if (following.contains(currLeague)) {
                  following.remove(currLeague);
                } else {
                  following.add(currLeague);
                }
              });
            },
            dense: true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, following)),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            labelText: 'Search For Leagues',
          ),
          autofocus: true,
          focusNode: _searchFocusNode,
          onSubmitted: (String str) {
            setState(() {
              _leagues = searchLeagues(_searchController.text);
            });
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                _searchFocusNode.unfocus();
                setState(() {
                  _leagues = searchLeagues(_searchController.text);
                });
              }),
        ],
      ),
      body: FutureBuilder(
        future: _leagues,
        builder:
            (BuildContext context, AsyncSnapshot<List<LeagueExtra>> snapshot) {
          if (snapshot.hasData) {
            return _displayResults(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load search results.'),
            );
          }

          return Container();
        },
      ),
    );
  }
}
