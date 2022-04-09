import 'package:json_annotation/json_annotation.dart';

part 'addition.g.dart';

@JsonSerializable()
class Clouds {
  const Clouds(this.all);
  final int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Coord {
  const Coord(this.lon, this.lat);
  final double lon;
  final double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Main {
  const Main({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.tempMax,
    required this.tempMin,
  });
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Sys {
  const Sys(
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  );
  final int type;
  final int id;
  final String country;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime sunrise;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class WeatherItem {
  const WeatherItem(this.description, this.icon, this.id, this.main);
  final int id;
  final String main;
  final String description;
  final String icon;

  factory WeatherItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherItemToJson(this);
}

@JsonSerializable()
class Wind {
  const Wind(this.speed, this.deg);
  final double speed;
  final int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class City {
  const City(
    this.coord,
    this.country,
    this.id,
    this.name,
    this.population,
    this.sunset,
    this.sunrise,
    this.timezone,
  );
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime sunrise;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime sunset;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

DateTime dateTimeFromTimestamp(int timestamp) {
  return DateTime.fromMicrosecondsSinceEpoch(timestamp);
}
