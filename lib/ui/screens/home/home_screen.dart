import 'package:Array_App/bloc/weather/weather_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/ui/widget/indicator/linear_progress_indicator.dart';
import 'package:Array_App/ui/widget/weather/weather_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../bloc/weather/weather_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    // insideWeatherData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.0));
    final surface = Theme.of(context).colorScheme.surface;
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(StyleConfig.defaultMargin),
          child: Column(
            children: [
              _greetingWidget(),
              _weatherWidget(),
              _bodyMeasurementWidget(
                borderRadius,
                shadowColor,
                surfaceTint,
                surface,
              ),
              _dataRowWidget(),
              const SizedBox(height: 40),
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
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Padding _bodyMeasurementWidget(
    BorderRadius borderRadius,
    Color shadowColor,
    Color surfaceTint,
    Color surface,
  ) {
    final widgetPrimaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: widgetPrimaryColor,
        );
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.defaultPadding),
      child: Material(
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTint,
        color: surface,
        type: MaterialType.card,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(StyleConfig.defaultPadding),
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  context.l10n.bodyMeasurement,
                  style: textStyle,
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: widgetPrimaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _greetingWidget() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.defaultPadding),
      child: Row(
        children: [
          Text(
            l10n.homeScreenGreeting,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: StyleConfig.defaultMargin),
          Text(
            // TODO(jtl): add name user name from bloc
            'Emily!',
            style: Theme.of(context).textTheme.displaySmall?.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const Spacer(),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  Padding _dataRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.defaultPadding),
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('${state.items.length}',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('items',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
                Column(
                  children: [
                    Text('${state.items.length}',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('items',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
                Column(
                  children: [
                    Text('${state.items.length}',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('items',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  BlocBuilder<ItemBloc, ItemState> _latestItemWidget(double height) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoading) {
          return const CircularProgressIndicator();
        } else if (state is ItemLoaded) {
          return SizedBox(
            height: state.items.isNotEmpty ? height * 0.3 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(
                    state.items.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.white,
                          child: Column(
                            children: [
                              if (state.items[index].imageData != null)
                                Image(
                                  image: MemoryImage(
                                    state.items[index].imageData!,
                                  ),
                                ),
                              const Spacer(),
                              Text('Item ${index + 1}'),
                            ],
                          ),
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

  Card _weatherWidget() {
    final l10 = context.l10n;
    final date = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMM d', 'en_US').format(date);
    final widgetPrimaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyleFirstRow = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.apply(color: widgetPrimaryColor);
    final textStyleSecondRow = Theme.of(context)
        .textTheme
        .labelSmall
        ?.apply(color: widgetPrimaryColor);
    return Card(
      margin: const EdgeInsets.all(StyleConfig.defaultMargin),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return CustomLinearProgressIndicator();
          } else if (state is WeatherLoaded) {
            return Padding(
              padding: const EdgeInsets.all(StyleConfig.defaultMargin),
              child: Column(
                children: [
                  Row(
                    children: [
                      _getWeatherIcon(state, widgetPrimaryColor),
                      const SizedBox(width: StyleConfig.defaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: textStyleFirstRow,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _getDateTemp(state, context, textStyleSecondRow),
                              const SizedBox(width: 8),
                              Text(
                                '${state.data?.name}',
                                style: textStyleSecondRow,
                              ),
                              Icon(
                                Icons.location_on,
                                color: widgetPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is WeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10.homeScreenWeatherError),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Text _getDateTemp(
      WeatherLoaded state, BuildContext context, TextStyle? style) {
    return Text(_getMinMaxTemperature(state), style: style);
  }

  String _getMinMaxTemperature(WeatherLoaded state) {
    final minTemp = state.data?.main?.tempMin ?? 0.0;
    final maxTemp = state.data?.main?.tempMax ?? 0.0;
    final minTempStr = kelvinToCelsius(minTemp).toStringAsFixed(0);
    final maxTempStr = kelvinToCelsius(maxTemp).toStringAsFixed(0);
    return '$minTempStr°C | $maxTempStr°C';
  }

  Icon _getWeatherIcon(WeatherLoaded state, Color? color) {
    return Icon(
      size: 40,
      color: color,
      WeatherIcon.mapToIcon(
        getWeatherConditionString(
          state.data?.weather?.first.id ?? 0,
        ),
      ),
    );
  }
}
