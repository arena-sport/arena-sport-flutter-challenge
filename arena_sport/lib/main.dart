import 'dart:collection';

import 'package:arena_sport/search_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'api_models.dart';
import 'home_page.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARENA',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.grey,
        // primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppBase(title: 'ARENA'),
    );
  }
}

class AppBase extends StatefulWidget {
  AppBase({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<AppBase> createState() => AppBaseState();
}

class AppBaseState extends State<AppBase> {
  int _currentIndex = 0;

  // models
  final UserInfoModel _userInfo =
      UserInfoModel.fromSave(''); // TODO get saved user info from memory
  final HomePageModel _homePageModel =
      HomePageModel.fromSave(''); // TODO also retrieve from memory

  @override
  void initState() {
    super.initState();

    // Start model
    _homePageModel.start();
  }

  @override
  Widget build(BuildContext context) {
    /*if (_userInfo.country == null) {
      _chooseCountry(context, _choseCountry);
    }*/

    return ScopedModel(
      model: _userInfo,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            _LiveSwitch(),
            _SearchButton(_homePageModel),
          ],
        ),
        body: (int curr) {
          switch (curr) {
            case 0:
              return HomePage(_homePageModel);
            case 1:
              return null;
            case 2:
              return null;
            case 3:
              return null;
            case 4:
              return null;
          }
        }(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.grey,
                  size: 36.0,
                ),
                label: 'Home',
                activeIcon: const Icon(
                  Icons.home_outlined,
                  color: Colors.blueAccent,
                  size: 36.0,
                )),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.bar_chart,
                color: Colors.grey,
                size: 36.0,
              ),
              label: 'Stats',
              activeIcon: const Icon(
                Icons.bar_chart,
                color: Colors.blueAccent,
                size: 36.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.ac_unit,
                color: Colors.grey,
                size: 36.0,
              ),
              label: '',
              activeIcon: const Icon(
                Icons.ac_unit,
                color: Colors.blueAccent,
                size: 36.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.live_tv,
                color: Colors.grey,
                size: 36.0,
              ), // can be changed for Icons.tv
              label: '',
              activeIcon: const Icon(
                Icons.live_tv,
                color: Colors.blueAccent,
                size: 36.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.language,
                color: Colors.grey,
                size: 36.0,
              ),
              label: '',
              activeIcon: const Icon(
                Icons.language,
                color: Colors.blueAccent,
                size: 36.0,
              ),
            )
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: (int t) {
            setState(() {
              _currentIndex = t;
            });
          },
        ),
      ),
    );
  }
}

class _LiveSwitch extends StatelessWidget {
  final Key key;

  _LiveSwitch({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScopedModelDescendant<UserInfoModel>(
          builder: (context, child, model) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Live',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: model.isLive ? Colors.red : Colors.grey[700]),
                ),
                Switch(
                  value: model.isLive,
                  onChanged: (bool) {
                    model.setIsLive(bool);
                  },
                  inactiveTrackColor: Colors.grey[300],
                  inactiveThumbColor: Colors.grey,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SearchButton extends StatelessWidget {
  final Key key;
  final HomePageModel _homePageModel;

  _SearchButton(this._homePageModel, {this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.grey[300],
        child: Icon(
          Icons.search_rounded,
          size: 28.0,
          color: Colors.grey,
        ),
        padding: EdgeInsets.all(4.0),
        shape: CircleBorder(),
        minWidth: 24.0,
        height: 24.0,
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<HashSet<LeagueExtra>>(
                  builder: (context) =>
                      SearchPage(_homePageModel.leaguesFollowing)),
            ).then(
                (response) => _homePageModel.leaguesFollowing.set(response)));
  }
}

// export PATH="$PATH:/Users/projects/flutter/bin"
