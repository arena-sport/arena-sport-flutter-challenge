import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import 'stats_page.dart';
import 'api_models.dart';
import 'home_page.dart';

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;

    notifyListeners();
  }
}

////////////////////////////////////////////////////
// User Info Model
////////////////////////////////////////////////////

class UserInfoModel extends Model {
  Country _country;
  List<LeagueExtra> _leagues;
  bool _isLive;

  // Getters
  Country get country => _country;
  List<LeagueExtra> get leagues => _leagues;
  bool get isLive => _isLive;

  UserInfoModel()
      : _country = null,
        _leagues = List<LeagueExtra>(),
        _isLive = false;

  factory UserInfoModel.fromSave(String filePath) {
    // TODO implement fetching UserInfoModel from persistent storage
    return UserInfoModel();
  }

  void setUserCountry(Country country) {
    _country = country;

    notifyListeners();
  }

  void setUserLeagues(List<LeagueExtra> leagues) {
    _leagues = leagues;

    notifyListeners();
  }

  void setIsLive(bool newIsLive) {
    _isLive = newIsLive;

    notifyListeners();
  }
}

////////////////////////////////////////////////////
// Home Page Model
////////////////////////////////////////////////////

class HomePageModel extends Model {
  ModelHashSet<TeamExtra> _teamsFollowing;
  ModelHashSet<LeagueExtra> _leaguesFollowing;

  HomePageModel();

  factory HomePageModel.fromSave(String filePath) {
    // TODO implement fetching from save
    return HomePageModel();
  }

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  // Getters
  ModelHashSet<TeamExtra> get teamsFollowing =>
      _teamsFollowing ?? ModelHashSet<TeamExtra>(this.notifyListeners);
  ModelHashSet<LeagueExtra> get leaguesFollowing =>
      _leaguesFollowing ?? ModelHashSet<LeagueExtra>(this.notifyListeners);

  set teamsFollowing(ModelHashSet<TeamExtra> newTeams) {
    _teamsFollowing = newTeams;
    notifyListeners();
  }

  set leaguesFollowing(ModelHashSet<LeagueExtra> newLeagues) {
    _leaguesFollowing = newLeagues;
    notifyListeners();
  }
}

class ModelMap<K, V> {
  Map<K, V> _map;
  void Function() _notifyListeners;

  ModelMap(void notify(), {Map<K, V> map}) {
    this._map = map ?? Map<K, V>();
    this._notifyListeners = notify;
  }

  factory ModelMap.fromSave(String filePath) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  factory ModelMap.fromJson(Map<String, dynamic> json) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  void notifyWith(void Function() notify) {
    this._notifyListeners = notify;
  }

  operator [](Object key) => this._map[key];
  operator []=(K key, V value) => this._map[key] = value;

  int get length => this._map.length;
  bool get isEmpty => this._map.isEmpty;
  Iterable<K> get keys => this._map.keys;
  Iterable<V> get values => this._map.values;

  void set(Map<K, V> set) {
    this._map = set;

    this._notifyListeners();
  }

  void addAll(Map<K, V> other) {
    this._map.addAll(other);

    this._notifyListeners();
  }

  V remove(K key) {
    V value = this._map.remove(key);

    this._notifyListeners();

    return value;
  }

  bool containsKey(K key) => this._map.containsKey(key);

  bool containsValue(V value) => this._map.containsValue(value);

  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> f(K key, V value)) =>
      this._map.map(f);
}

class ModelHashSet<E> {
  HashSet<E> _hashSet;
  void Function() _notifyListeners;

  ModelHashSet(void notify(), {HashSet<E> set}) {
    this._hashSet = set ?? HashSet<E>();
    this._notifyListeners = notify;
  }

  factory ModelHashSet.fromSave(String filePath) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  factory ModelHashSet.fromJson(Map<String, dynamic> json) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  void notifyWith(void Function() notify) {
    this._notifyListeners = notify;
  }

  bool get isEmpty => this._hashSet.isEmpty;
  // Get size of Set
  int get length => this._hashSet.length;
  // Get first element in set
  E get first => this._hashSet.first;

  // Adds league to the set.
  // Returns true if league (or equivalent value) was not yet in the set.
  // Otherwise returns false and the set is not changed.
  bool add(E item) {
    bool b = this._hashSet.add(item);

    this._notifyListeners();

    return b;
  }

  // Adds leagues to the set.
  void addAll(Iterable<E> elements) {
    this._hashSet.addAll(elements);

    this._notifyListeners();
  }

  // Removes leagues from the set.
  // Returns true if team was in the set. Returns false otherwise.
  // The method has no effect if league value was not in the set.
  bool remove(E item) {
    bool b = this._hashSet.remove(item);

    this._notifyListeners();

    return b;
  }

  // Removes leagues from the set.
  void removeAll(Iterable<E> elements) {
    this._hashSet.removeAll(elements);

    this._notifyListeners();
  }

  // Returns true if team is in the set.
  bool contains(E item) => this._hashSet.contains(item);

  Iterable<T> map<T>(T func(E value)) => _hashSet.map(func);

  bool any(bool test(E element)) => _hashSet.any(test);

  E singleWhere(bool test(E element), {E orElse()}) =>
      _hashSet.singleWhere(test, orElse: orElse);
}

////////////////////////////////////////////////////
// Activity Model
////////////////////////////////////////////////////

typedef void ChangeMainBody(int index, {HomePage home, StatsPage stats});

class ActivityModel extends Model {
  static ActivityModel of(BuildContext context) =>
      ScopedModel.of<ActivityModel>(context);

  ActivityModel({ChangeMainBody changeMainBody}) {
    _changeMainBody = changeMainBody;
  }

  ChangeMainBody _changeMainBody;

  // Gets function.
  ChangeMainBody get changeMainBody => _changeMainBody;

  // sets function if provided function is non-null. Cannot set to null.
  set changeMainBody(ChangeMainBody change) {
    _changeMainBody = change ?? _changeMainBody;
    notifyListeners();
  }
}
