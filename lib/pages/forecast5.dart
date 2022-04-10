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

class _Forecast5State extends State<Forecast5>
    with AutomaticKeepAliveClientMixin {
  late ValueNotifier<WeatherResult?> result;

  @override
  void initState() {
    result = ValueNotifier<WeatherResult?>(null);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<WeatherResult>(
          future:
              ApiRequests.getWeather(context.read<LocationNotifier>().state!),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error!.toString()),
              );
            }
            var value = snapshot.data!;
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(value),
                  const SliverToBoxAdapter(child: Divider()),
                  _buildSunrise(value),
                  const SliverToBoxAdapter(child: Divider()),
                  ...value.list.map((e) => _buildDay(e))
                ],
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
