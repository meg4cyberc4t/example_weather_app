import 'package:json_annotation/json_annotation.dart';

import 'addition.dart';

part 'current_result.g.dart';

@JsonSerializable()
class CurrentResult {
  const CurrentResult(
      this.clouds,
      this.cod,
      this.coord,
      this.dt,
      this.id,
      this.main,
      this.name,
      this.sys,
      this.timezone,
      this.visibility,
      this.weather,
      this.wind);
  final Coord coord;
  final List<WeatherItem> weather;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory CurrentResult.fromJson(Map<String, dynamic> json) =>
      _$CurrentResultFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentResultToJson(this);
}

// {
//   "cod": "200",
//   "message": 0,
//   "cnt": 40,
//   "list": [
//     {
//       "dt": 1647345600,
//       "main": {
//         "temp": 286.88,
//         "feels_like": 285.93,
//         "temp_min": 286.74,
//         "temp_max": 286.88,
//         "pressure": 1021,
//         "sea_level": 1021,
//         "grnd_level": 1018,
//         "humidity": 62,
//         "temp_kf": 0.14
//       },
//       "weather": [
//         {
//           "id": 804,
//           "main": "Clouds",
//           "description": "overcast clouds",
//           "icon": "04d"
//         }
//       ],
//       "clouds": {
//         "all": 85
//       },
//       "wind": {
//         "speed": 3.25,
//         "deg": 134,
//         "gust": 4.45
//       },
//       "visibility": 10000,
//       "pop": 0,
//       "sys": {
//         "pod": "d"
//       },
//       "dt_txt": "2022-03-15 12:00:00"
//     },
//     {
//       "dt": 1647356400,
//       "main": {
//         "temp": 286.71,
//         "feels_like": 285.77,
//         "temp_min": 286.38,
//         "temp_max": 286.71,
//         "pressure": 1021,
//         "sea_level": 1021,
//         "grnd_level": 1017,
//         "humidity": 63,
//         "temp_kf": 0.33
//       },
//       "weather": [
//         {
//           "id": 804,
//           "main": "Clouds",
//           "description": "overcast clouds",
//           "icon": "04d"
//         }
//       ],
//       "clouds": {
//         "all": 90
//       },
//       "wind": {
//         "speed": 3.34,
//         "deg": 172,
//         "gust": 4.03
//       },
//       "visibility": 10000,
//       "pop": 0,
//       "sys": {
//         "pod": "d"
//       },
//       "dt_txt": "2022-03-15 15:00:00"
//     },

//     ...

//  ],
//   "city": {
//     "id": 2643743,
//     "name": "London",
//     "coord": {
//       "lat": 51.5073,
//       "lon": -0.1277
//     },
//     "country": "GB",
//     "population": 1000000,
//     "timezone": 0,
//     "sunrise": 1647324903,
//     "sunset": 1647367441
//   }
// }
     