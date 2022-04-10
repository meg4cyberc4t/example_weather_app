import 'package:example_weather_app/notifiers/location/location_notifier.dart';
import 'package:example_weather_app/service/api_requests.dart';
import 'package:example_weather_app/service/models/current_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Current extends StatefulWidget {
  const Current({Key? key}) : super(key: key);

  @override
  State<Current> createState() => _CurrentState();
}

class _CurrentState extends State<Current> with AutomaticKeepAliveClientMixin {
  Widget _buildAppBar(CurrentResult result) {
    return SliverAppBar(
      title: Text(
        result.name,
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

  Widget _buildWind(CurrentResult result) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Chip(
            label: Text("${result.wind.speed.toString()} км/ч"),
            avatar: const Icon(Icons.air),
          ),
          Chip(
            label: Text("${result.main.humidity.toString()}%"),
            avatar: const Icon(Icons.water_drop_outlined),
          ),
          Chip(
            label: Text("${result.main.pressure.toString()} гПа"),
            avatar: const Icon(Icons.error_outline),
          )
        ],
      ),
    );
  }

  Widget _buildSunrise(CurrentResult result) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.sunny),
            title: const Text('Восход солнца'),
            trailing: Text(DateFormat("HH:mm").format(result.sys.sunrise)),
          ),
          ListTile(
            leading: const Icon(Icons.nightlight),
            title: const Text('Заход солнца'),
            trailing: Text(DateFormat("HH:mm").format(result.sys.sunset)),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(CurrentResult result) {
    return SliverToBoxAdapter(
      child: ListTile(
        leading: const Icon(Icons.share),
        title: const Text('Поделиться'),
        onTap: () => Share.share(
            "Хочу поделиться с тобой погодой! Кстати сегодня ${result.main.temp.toString()}°!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<CurrentResult>(
        future: ApiRequests.getCurrent(context.read<LocationNotifier>().state!),
        builder: (context, snapshot) {
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
                _buildIndicators(value),
                _buildWind(value),
                _buildSunrise(value),
                _buildShareButton(value),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
