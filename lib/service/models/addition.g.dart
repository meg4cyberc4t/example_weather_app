// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
      json['all'] as int,
    );

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      (json['lon'] as num).toDouble(),
      (json['lat'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      tempMax: (json['temp_max'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
      json['type'] as int,
      json['id'] as int,
      json['country'] as String,
      dateTimeFromTimestamp(json['sunrise'] as int),
      dateTimeFromTimestamp(json['sunset'] as int),
    );

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };

WeatherItem _$WeatherItemFromJson(Map<String, dynamic> json) => WeatherItem(
      json['description'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['main'] as String,
    );

Map<String, dynamic> _$WeatherItemToJson(WeatherItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num).toDouble(),
      json['deg'] as int,
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      Coord.fromJson(json['coord'] as Map<String, dynamic>),
      json['country'] as String,
      json['id'] as int,
      json['name'] as String,
      json['population'] as int,
      dateTimeFromTimestamp(json['sunset'] as int),
      dateTimeFromTimestamp(json['sunrise'] as int),
      json['timezone'] as int,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
      'country': instance.country,
      'population': instance.population,
      'timezone': instance.timezone,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };
