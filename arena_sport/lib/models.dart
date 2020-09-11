import 'dart:collection';

import 'api_models.dart';

import 'package:scoped_model/scoped_model.dart';

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

class ModelHashSet<E> {
  HashSet<E> _hashSet;
  void Function() _notifyListeners;

  ModelHashSet(HashSet<E> s) {
    this._hashSet = s;
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

  // Get size of Set
  int get length => this._hashSet.length;
  // Get first element in set
  E get first => this._hashSet.first;

  // sets the new current HashSet to the provided HashSet
  void set(HashSet<E> set) {
    this._hashSet = set;

    this._notifyListeners();
  }

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
  bool contains(E item) {
    bool b = this._hashSet.contains(item);

    this._notifyListeners();

    return b;
  }

  Iterable<T> map<T>(T func(E value)) {
    return _hashSet.map(func);
  }
}

class HomePageModel extends Model {
  ModelHashSet<TeamExtra> _teamsFollowing;
  ModelHashSet<LeagueExtra> _leaguesFollowing;

  HomePageModel()
      : _teamsFollowing = ModelHashSet<TeamExtra>(HashSet<TeamExtra>()),
        _leaguesFollowing = ModelHashSet<LeagueExtra>(HashSet<LeagueExtra>());

  factory HomePageModel.fromSave(String filePath) {
    // TODO implement fetching from save
    return HomePageModel();
  }

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    // TODO implement
    throw Exception('Not yet implemented.');
  }

  // Getters
  ModelHashSet<TeamExtra> get teamsFollowing => _teamsFollowing;
  ModelHashSet<LeagueExtra> get leaguesFollowing => _leaguesFollowing;

  void start() {
    this._teamsFollowing.notifyWith(this.notifyListeners);
  }
}
