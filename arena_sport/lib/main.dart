import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (int curr) {
        switch (curr) {
          case 0:
            return null;
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
            icon: const Icon(Icons.home_outlined, color: Colors.white70,),
            // label: '',
            activeIcon: const Icon(Icons.home_outlined, color: Colors.black,)
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart, color: Colors.white70,),
            // label: '',
            activeIcon: const Icon(Icons.bar_chart, color: Colors.black,),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.ac_unit, color: Colors.white70,),
            // label: '',
            activeIcon: const Icon(Icons.ac_unit, color: Colors.black,),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.live_tv, color: Colors.black,), // can be changed for Icons.tv
            // label: '',
            activeIcon: const Icon(Icons.live_tv, color: Colors.white70,),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.language, color: Colors.black,),
            // label: '',
            activeIcon: const Icon(Icons.language, color: Colors.white70,),
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
    );
  }
}
