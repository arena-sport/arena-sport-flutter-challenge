import 'dart:collection';

import 'package:arena_sport/search_page.dart';
import 'package:arena_sport/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'api_models.dart';
import 'home_page.dart';
import 'models.dart';

void main() {
  runApp(Arena());
}

class Arena extends StatelessWidget {
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
  // models
  final UserInfoModel _userInfo =
      UserInfoModel.fromSave(''); // TODO get saved user info from memory
  final HomePageModel _homePageModel =
      HomePageModel.fromSave(''); // TODO also retrieve from memory
  final ActivityModel _activityModel = ActivityModel();

  // Icons for bottom navigation bar
  List<IconData> bNavIcons = [
    Icons.home_outlined,
    Icons.bar_chart,
    Icons.ac_unit,
    Icons.live_tv,
    Icons.language,
  ];

  // Params to control scaffold body
  Widget _appBody;
  int _bNavIndex;

  @override
  void initState() {
    super.initState();

    // Finish initializing _activityModel
    _activityModel.changeMainBody = changeBodyTo;

    // initialize scaffold body
    _appBody = HomePage(_homePageModel);
    _bNavIndex = 0;
  }

  // To change to a different body
  void changeBodyTo(int index, {HomePage home, StatsPage stats}) {
    if (index == this._bNavIndex) {
      return;
    }

    setState(() {
      this._bNavIndex = index;

      this._appBody = () {
        switch (index) {
          case 0:
            return home ?? HomePage(_homePageModel);
          case 1:
            return stats ?? StatsPage();
          case 2:
          case 3:
          case 4:
          default:
            return null;
        }
      }();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _activityModel,
      child: ScopedModel(
        model: _userInfo,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            actions: [
              _LiveSwitch(),
              _SearchButton(_homePageModel),
            ],
          ),
          body: _appBody,
          bottomNavigationBar: BottomNavigationBar(
            items: bNavIcons
                .map<BottomNavigationBarItem>(
                    (iconData) => BottomNavigationBarItem(
                          icon: Icon(
                            iconData,
                            color: Colors.grey,
                            size: 36.0,
                          ),
                          label: '',
                          activeIcon: Icon(
                            iconData,
                            color: Colors.blueAccent,
                            size: 36.0,
                          ),
                        ))
                .toList(),
            type: BottomNavigationBarType.shifting,
            currentIndex: this._bNavIndex,
            onTap: (int index) {
              setState(() {
                changeBodyTo(index);
              });
            },
          ),
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
              MaterialPageRoute<ModelHashSet<LeagueExtra>>(
                  builder: (context) =>
                      SearchPage(_homePageModel.leaguesFollowing)),
            ).then((response) => _homePageModel.leaguesFollowing = response));
  }
}
// export PATH="$PATH:/Users/projects/flutter/bin"
