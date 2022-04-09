// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentResult _$CurrentResultFromJson(Map<String, dynamic> json) =>
    CurrentResult(
      Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      json['cod'] as int,
      Coord.fromJson(json['coord'] as Map<String, dynamic>),
      dateTimeFromTimestamp(json['dt'] as int),
      json['id'] as int,
      Main.fromJson(json['main'] as Map<String, dynamic>),
      json['name'] as String,
      Sys.fromJson(json['sys'] as Map<String, dynamic>),
      json['timezone'] as int,
      json['visibility'] as int,
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentResultToJson(CurrentResult instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'dt': instance.dt.toIso8601String(),
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };
