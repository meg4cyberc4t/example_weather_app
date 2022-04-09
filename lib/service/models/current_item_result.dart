import 'package:json_annotation/json_annotation.dart';

import 'addition.dart';

part 'current_item_result.g.dart';

@JsonSerializable()
class CurrentItemResult {
  const CurrentItemResult(
    this.clouds,
    this.dt,
    this.main,
    this.visibility,
    this.weather,
    this.wind,
    this.dtTxt,
    this.pop,
  );
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime dt;
  final Main main;
  final List<WeatherItem> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  @JsonKey(name: 'dt_txt')
  final DateTime dtTxt;

  factory CurrentItemResult.fromJson(Map<String, dynamic> json) =>
      _$CurrentItemResultFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentItemResultToJson(this);
}
