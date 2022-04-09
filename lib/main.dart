import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationNotifier>(
      create: (context) => LocationNotifier(),
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
          }
        },
        child: ListView(
          children: [
            Consumer<LocationNotifier>(
              builder: (context, value, child) => ListTile(
                title: Text(
                  value.state.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
