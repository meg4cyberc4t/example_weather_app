import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:example_weather_app/notifiers/connection/connection_enum.dart';
import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/pages/current.dart';
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
        theme: ThemeData.light(),
        home: const MyHomePage(),
        locale: const Locale('ru', 'RU'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Current();
  }
}
