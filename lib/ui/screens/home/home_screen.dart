import 'package:Array_App/data/repository/weather_repository_impl.dart';
import 'package:Array_App/domain/weather_repository.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_bloc.dart';
import '../../../bloc/item_state.dart';
import '../../../domain/entity/weather/current_weather_data.dart';
import '../../../main_development.dart';
import '../../widget/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CurrentWeatherData weatherData = CurrentWeatherData();
  int count = 0;
  WeatherRepository weatherRepository = WeatherRepositoryImpl();

  @override
  void initState() {
    super.initState();
    insideWeatherData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> insideWeatherData() async {
    // add this to userbloc
    weatherData = await weatherRepository.getWeather('London');
    setState(() {
      weatherData = weatherData;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state.status == ItemStateStatus.initial) {
            return Column(
              children: [
                Text(state.items.toString()),
              ],
            );
          } else if (state.status == ItemStateStatus.loadSuccess) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weatherData.id == null
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          child: Column(
                          children: [
                            Text(weatherData.name ?? ''),
                            Icon(Icons.wb_sunny),
                            Text(DateTime.now().toString()),
                            Text('${weatherData.main?.temp}°C'),
                            Text('${weatherData.main?.humidity}'),
                          ],
                        )),
                  Text('Items ${state.items.toString()}'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      backgroundColor: Colors.red, // foreground
                    ),
                    onPressed: () {
                      BlocProvider.of<ItemBloc>(context).add(
                        ItemLoadStarted(),
                      );
                    },
                    child: const Text('Load Success'),
                  )
                ]);
          } else if (state.status == ItemStateStatus.loadFailure) {
            return Column(children: [
              Text("Items ${state.items.toString()}"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  logger.i("State:", state);
                  BlocProvider.of<ItemBloc>(context).add(
                    ItemLoadStarted(),
                  );
                },
                child: const Text('Load Failure'),
              )
            ]);
          } else {
            logger
              ..i("State: $state")
              ..i("Status:", state.status)
              ..i("Items:", state.items)
              ..i("Length:", state.items.length)
              ..i("SelectedItem:", state.selectedItem)
              ..i("State Page:", state.page)
              ..i("State Error:", state.error);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("This is else"),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ItemBloc>(context).add(
                      ItemLoadStarted(),
                    );
                  },
                  child: const Text('Load Items'),
                )
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
