import 'package:Array_App/bloc/weather/weather_state.dart';
import 'package:Array_App/data/repository/weather_repository_impl.dart';
import 'package:Array_App/domain/repository/weather_repository.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/ui/widget/weather/weather_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../bloc/weather/weather_bloc.dart';
import '../../../domain/entity/weather/current_weather_data.dart';
import '../../../main_development.dart';
import '../../../rest/util/util_functions.dart';
import '../../widget/bottom_nav_bar.dart';
import '../../widget/weather/weather_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    // insideWeatherData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> insideWeatherData() async {
  //   // add this to userbloc
  //   weatherData = await weatherRepository.getWeather('London');
  //   setState(() {
  //     weatherData = weatherData;
  //   });
  // }

  @override
  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final date = DateTime.now();
    final formattedDate = DateFormat('E, MMM d').format(date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _weatherWidget(formattedDate, l10),
              SizedBox(
                height: 45,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                // 'Hi, ${state.items[0].name}',
                'Hi, Test',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'This is your ARRAY',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 40),
              Container(
                width: width,
                height: height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Last item',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      _latestItemWidget(height),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  BlocBuilder<ItemBloc, ItemState> _latestItemWidget(double height) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoading) {
          return const CircularProgressIndicator();
        } else if (state is ItemLoaded) {
          return Container(
            height: state.items.isNotEmpty ? height * 0.3 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: List.generate(
                    state.items.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: Text('Item ${index + 1}'),
                        ),
                      );
                    },
                  ),
                ),
                // Text('Items ${state.items.length.toString()}'),
                // for (var item in state.items)
                //   Text(
                //     item.name ?? 'No name',
                //     style: const TextStyle(fontSize: 20),
                //   ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.white,
                //     backgroundColor: Colors.green, // foreground
                //   ),
                //   onPressed: () {
                //     BlocProvider.of<ItemBloc>(context).add(
                //       const LoadItem(),
                //     );
                //   },
                //   child: const Text('Load Success'),
                // )
              ],
            ),
          );
        } else if (state is ItemError) {
          return Column(
            children: [
              Text('Items ${state.items.toString()}'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  logger.i("State:", state);
                  BlocProvider.of<ItemBloc>(context).add(
                    const LoadItem(),
                  );
                },
                child: const Text('Load Failure'),
              )
            ],
          );
        } else {
          // logger
          //   ..i("State: $state")
          //   ..i('Items: ${state?.items} '
          //       '\nLength: ${state.items.length}'
          // '\nId: ${state.items[0]?.id} Name: ${state.items[0].name ?? ''}'
          // '\nSelectedItem: ${state.selectedItem}'
          // '\nState Error: ${state.exception}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("This is else"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // foreground
                ),
                onPressed: () {
                  BlocProvider.of<ItemBloc>(context).add(
                    const LoadItem(),
                  );
                },
                child: const Text("This is else"),
              )
            ],
          );
        }
      },
    );
  }

  BlocBuilder<WeatherBloc, WeatherState> _weatherWidget(
    String formattedDate,
    AppLocalizations l10,
  ) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const CircularProgressIndicator();
        } else if (state is WeatherLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '${state.data?.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Icon(Icons.location_on),
                ],
              ),
              Row(
                children: [
                  _getWeatherIcon(state),
                  Container(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      _getDateTemp(state, context),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else if (state is WeatherError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10.itemProfileScreenNotificationSave),
            ),
          );
        }
        return Container();
      },
    );
  }

  Text _getDateTemp(WeatherLoaded state, BuildContext context) {
    return Text(
      //add min max temperature
      _getTemp(state),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  String _getTemp(WeatherLoaded state) {
    var minTemp = state.data?.main?.tempMin ?? 0.0;
    var maxTemp = state.data?.main?.tempMax ?? 0.0;
    var minTempStr = kelvinToCelsius(minTemp).toStringAsFixed(0);
    final maxTempStr = kelvinToCelsius(maxTemp).toStringAsFixed(0);
    return '$minTempStr°C | $maxTempStr°C';
  }

  Icon _getWeatherIcon(WeatherLoaded state) {
    return Icon(
      size: 40,
      WeatherIcon.mapToIcon(
        getWeatherConditionString(
          state.data?.weather?.first.id ?? 0,
        ),
      ),
    );
  }
}
