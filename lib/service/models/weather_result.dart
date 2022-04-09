import 'package:example_weather_app/service/models/addition.dart';
import 'package:example_weather_app/service/models/current_item_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_result.g.dart';

@JsonSerializable()
class WeatherResult {
  const WeatherResult(this.city, this.cnt, this.cod, this.list, this.message);
  final String cod;
  final int message;
  final int cnt;
  final List<CurrentItemResult> list;
  final City city;

  factory WeatherResult.fromJson(Map<String, dynamic> json) =>
      _$WeatherResultFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResultToJson(this);
}
