// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_item_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentItemResult _$CurrentItemResultFromJson(Map<String, dynamic> json) =>
    CurrentItemResult(
      Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      dateTimeFromTimestamp(json['dt'] as int),
      Main.fromJson(json['main'] as Map<String, dynamic>),
      json['visibility'] as int,
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
      DateTime.parse(json['dt_txt'] as String),
      (json['pop'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentItemResultToJson(CurrentItemResult instance) =>
    <String, dynamic>{
      'dt': instance.dt.toIso8601String(),
      'main': instance.main,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'pop': instance.pop,
      'dt_txt': instance.dtTxt.toIso8601String(),
    };
