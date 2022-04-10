import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/service/api_requests.dart';
import 'package:example_weather_app/service/models/current_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Current extends StatefulWidget {
  const Current({Key? key}) : super(key: key);

  @override
  State<Current> createState() => _CurrentState();
}

class _CurrentState extends State<Current> {
  late ValueNotifier<CurrentResult?> result;

  @override
  void initState() {
    result = ValueNotifier<CurrentResult?>(null);
    super.initState();
  }

  Future<void> _updateCurrentWeather() async {
    LocationExceptionsEnum exceptions =
        await context.read<LocationNotifier>().updateLocation();
    if (exceptions != LocationExceptionsEnum.none) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(exceptions.name)));
      return;
    }
    result.value = await ApiRequests.getCurrent(
        Provider.of<LocationNotifier>(context, listen: false).state!);
  }

  Widget _buildAppBar(CurrentResult? result) {
    final DateTime dt = result?.dt.toLocal() ?? DateTime.now();

    return SliverAppBar(
      title: Text(
        DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(dt),
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildIndicators(CurrentResult result) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            result.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  " " + result.main.temp.toString() + "°",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.keyboard_arrow_down),
                    Text(result.main.tempMin.toString() + "°"),
                    const SizedBox(width: 16),
                    const Icon(Icons.keyboard_arrow_up),
                    Text(result.main.tempMax.toString() + "°"),
                  ],
                ),
              ],
            ),
          ),
          Chip(
            label: Text(
              result.weather.first.main,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoValueCard() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/cloudy.jpeg'),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Самый точный прогноз погоды!",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Узнать'),
            onPressed: _updateCurrentWeather,
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<CurrentResult?>(
          valueListenable: result,
          builder: (BuildContext context, CurrentResult? value, _) {
            if (value == null) return _buildNoValueCard();
            return Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(value),
                    _buildIndicators(value),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
