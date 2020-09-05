import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {

  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;

    notifyListeners();
  }
}

class UserInfoModel extends Model {

  String _country = '';

  String get country => _country;

  void setCountry(Country country) {
    _country = country.country;

    notifyListeners();
  }

  List<Country> getAllCountries() {

  }
}

// class for storing country data coming from api
class Country {
  final String country;
  final String code;
  final String flagUrl;

  Country({this.country, this.code, this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['country'],
      code: json['code'],
      flagUrl: json['flag'],
    );
  }
}

class HomePageModel extends Model {

}