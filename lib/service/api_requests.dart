import 'dart:convert';

import 'package:example_weather_app/service/models/current_result.dart';
import 'package:example_weather_app/service/models/weather_result.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class ApiRequests {
  static const appid = "d472750297a5e987c8c913d60504371d";

  static Future<CurrentResult> getCurrent(LocationData location) async {
    http.Response res = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?"
          "lat=${location.latitude}&"
          "lon=${location.longitude}&"
          "appid=$appid&"
          "lang=ru&"
          "units=metric&"
          "mode=json"),
    );
    return CurrentResult.fromJson(jsonDecode(res.body));
  }

  static Future<WeatherResult> getWeather(LocationData location) async {
    http.Response res = await http
        .get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?"
            "lat=${location.latitude}&"
            "lon=${location.longitude}&"
            "appid=$appid&"
            "lang=ru&"
            "units=metric&"
            "mode=json"));
    return WeatherResult.fromJson(jsonDecode(res.body));
  }
}
