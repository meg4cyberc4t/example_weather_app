import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:example_weather_app/notifiers/connection/connection_enum.dart';
import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/pages/current.dart';
import 'package:example_weather_app/pages/forecast5.dart';
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
        home: const Router(),
        locale: const Locale('ru', 'RU'),
      ),
    );
  }
}

class Router extends StatefulWidget {
  const Router({Key? key}) : super(key: key);

  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  final PageController _controller = PageController();
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationNotifier, ConnectionEnum>(
      builder: (context, location, connection, child) {
        if (location.state == null) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Геопозиция недоступна'),
                TextButton(
                  child: const Text('Повторить'),
                  onPressed: context.read<LocationNotifier>().updateLocation,
                )
              ],
            )),
          );
        } else if (connection == ConnectionEnum.disabled) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Интернет недоступен'),
                  TextButton(
                    child: const Text('Повторить'),
                    onPressed: context.read<LocationNotifier>().updateLocation,
                  )
                ],
              ),
            ),
          );
        }
        return child!;
      },
      child: Scaffold(
        body: PageView(
            controller: _controller,
            children: const [
              Current(),
              Forecast5(),
            ],
            onPageChanged: (final int value) => selectedIndex.value = value),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: selectedIndex,
          builder: (context, value, _) => NavigationBar(
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            animationDuration: const Duration(milliseconds: 400),
            selectedIndex: value,
            onDestinationSelected: _controller.jumpToPage,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.keyboard_capslock_outlined),
                label: 'Current',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_outlined),
                label: 'Forecast5',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
