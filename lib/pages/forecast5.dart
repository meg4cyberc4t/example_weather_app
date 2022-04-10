import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/service/api_requests.dart';
import 'package:example_weather_app/service/models/current_item_result.dart';
import 'package:example_weather_app/service/models/weather_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Forecast5 extends StatefulWidget {
  const Forecast5({Key? key}) : super(key: key);

  @override
  State<Forecast5> createState() => _Forecast5State();
}

class _Forecast5State extends State<Forecast5> {
  late ValueNotifier<WeatherResult?> result;

  @override
  void initState() {
    result = ValueNotifier<WeatherResult?>(null);
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
    result.value = await ApiRequests.getWeather(
        Provider.of<LocationNotifier>(context, listen: false).state!);
  }

  Widget _buildAppBar(WeatherResult result) {
    return SliverAppBar(
      title: Text(
        result.city.name,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDay(CurrentItemResult item) {
    String title = item.weather.first.description;
    return SliverToBoxAdapter(
      child: ListTile(
        title: Text(title[0].toUpperCase() + title.substring(1)),
        subtitle: Text('Ветер: ${item.wind.speed} км/ч'),
        trailing: Text(DateFormat('HH:mm dd.MM').format(item.dtTxt)),
        leading: SizedBox(
          height: 40,
          width: 40,
          child: Center(
            child: Text(
              item.main.temp.round().toString() + "°",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSunrise(WeatherResult result) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.sunny),
            title: const Text('Восход солнца'),
            trailing: Text(DateFormat("HH:mm").format(result.city.sunrise)),
          ),
          ListTile(
            leading: const Icon(Icons.nightlight),
            title: const Text('Заход солнца'),
            trailing: Text(DateFormat("HH:mm").format(result.city.sunset)),
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
      body: ValueListenableBuilder<WeatherResult?>(
          valueListenable: result,
          builder: (BuildContext context, WeatherResult? value, _) {
            if (value == null) return _buildNoValueCard();
            return Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(value),
                    const SliverToBoxAdapter(child: Divider()),
                    _buildSunrise(value),
                    const SliverToBoxAdapter(child: Divider()),
                    ...value.list.map((e) => _buildDay(e))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
