// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResult _$WeatherResultFromJson(Map<String, dynamic> json) =>
    WeatherResult(
      City.fromJson(json['city'] as Map<String, dynamic>),
      json['cnt'] as int,
      json['cod'] as String,
      (json['list'] as List<dynamic>)
          .map((e) => CurrentItemResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as int,
    );

Map<String, dynamic> _$WeatherResultToJson(WeatherResult instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list,
      'city': instance.city,
    };
