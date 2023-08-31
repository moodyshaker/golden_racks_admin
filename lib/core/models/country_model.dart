class Country {
  String? countryName;
  int? id;
  List<City>? cities;
  Country({
    this.countryName,
    this.cities,
    this.id,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryName:
          json['countryName'] != null ? json['countryName'] as String : null,
      id: json['id'] != null ? json['id'] as int : null,
      cities: json['cities'] != null
          ? List<City>.from(
              (json['cities'] as List<dynamic>).map<City?>(
                (x) => City.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class City {
  String? cityName;
  int? id;
  List<State>? states;
  City({
    this.cityName,
    this.id,
    this.states,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['cityName'] != null ? json['cityName'] as String : null,
      id: json['id'] != null ? json['id'] as int : null,
      states: json['states'] != null
          ? List<State>.from(
              (json['states'] as List<dynamic>).map<State?>(
                (x) => State.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class State {
  int? id;
  String? stateName;
  State({
    this.id,
    this.stateName,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'] != null ? json['id'] as int : null,
      stateName: json['stateName'] != null ? json['stateName'] as String : null,
    );
  }
}

// List<Country> countries = [];
// Future<void> getCountry() async {
//   var url = Uri.parse('http://109.123.244.24/api/Countries');

//   var header = {
//     'Accept-Language': 'ar',
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//   };

//   var response = await http.get(url, headers: header);

//   List jsonResponse = jsonDecode(response.body);
//   countries = jsonResponse.map((data) => Country.fromJson(data)).toList();
// }
