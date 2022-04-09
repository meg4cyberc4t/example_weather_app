import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:example_weather_app/notifiers/connection/connection_enum.dart';
import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/service/api_requests.dart';
import 'package:example_weather_app/service/models/weather_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationNotifier>(
          create: (context) => LocationNotifier(),
        ),
        StreamProvider<ConnectionEnum>(
          create: (context) => Connectivity().isConnected.map(
                (event) => event == true
                    ? ConnectionEnum.enabled
                    : ConnectionEnum.disabled,
              ),
          initialData: Connectivity().isConnected.valueOrNull == true
              ? ConnectionEnum.enabled
              : ConnectionEnum.disabled,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<WeatherResult?> result = ValueNotifier(null);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          LocationExceptionsEnum exceptions =
              await Provider.of<LocationNotifier>(context, listen: false)
                  .updateLocation();
          if (exceptions != LocationExceptionsEnum.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exceptions.name),
              ),
            );
            return;
          }
          await ApiRequests.getCurrent(
              Provider.of<LocationNotifier>(context, listen: false).state!);
          result.value = await ApiRequests.getWeather(
              Provider.of<LocationNotifier>(context, listen: false).state!);
        },
        child: ValueListenableBuilder<WeatherResult?>(
          valueListenable: result,
          builder: (context, WeatherResult? value, _) => ListView(
            children: [
              SizedBox(
                child:
                    Center(child: Text(value?.city.name.toString() ?? "none")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
