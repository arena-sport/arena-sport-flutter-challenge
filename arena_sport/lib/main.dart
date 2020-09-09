import 'package:arena_sport/search_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_page.dart';
import 'models.dart';
import 'api.dart' as api;
import 'api_models.dart';

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
  Future<List<Country>> _countries;

  // models
  final UserInfoModel _userInfo =
      UserInfoModel(); // TODO get saved user info from memory
  final HomePageModel _homePageModel =
      HomePageModel(); // TODO also retrieve from memory

  void _chooseCountry(BuildContext context, giveCountry c) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder<List<Country>>(
          future: _countries,
          builder:
              (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
            if (snapshot.hasData) {
              // If data has come through successfully
              // Return list of tile with countries to select from
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // Show flag logo
                    leading: api.getCountryImage(
                      snapshot.data[index],
                    ),
                    // Show Country name
                    title: Text(snapshot.data[index].country),
                    // if chosen, return country chosen and then remove the bottomsheet
                    onTap: () {
                      c(snapshot.data[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('ERROR'),
              );
            } else {
              // If still waiting for results, show progress indicator
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
          },
        );
      },
    );
  }

  void _choseCountry(Country country) {
    _userInfo.setUserCountry(country);
  }

  @override
  void initState() {
    _countries = api.getCountriesList();

    super.initState();
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
            _SearchButton(),
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
              children: [
                Text(
                  'LIVE',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: model.isLive ? Colors.red : Colors.grey),
                ),
                Switch(
                    value: model.isLive,
                    onChanged: (bool) {
                      model.setIsLive(bool);
                    })
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

  _SearchButton({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      child: Icon(
        Icons.search,
        size: 24.0,
        color: Colors.grey,
      ),
      padding: EdgeInsets.all(8.0),
      shape: CircleBorder(),
      minWidth: 24.0,
      height: 24.0,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      ),
    );
  }
}

// export PATH="$PATH:/Users/projects/flutter/bin"
