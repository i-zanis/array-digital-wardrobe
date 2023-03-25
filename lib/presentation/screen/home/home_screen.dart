import 'package:Array_App/bloc/weather/weather_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../bloc/weather/weather_bloc.dart';
import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import '../../../rest/util/util_functions.dart';
import '../../widget/indicator/linear_progress_indicator.dart';
import '../../widget/sized_box_x8.dart';
import '../../widget/weather/weather_functions.dart';
import '../../widget/weather/weather_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const borderRadius = BorderRadius.all(Radius.circular(8.0));
    final surface = Theme.of(context).colorScheme.surface;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final surfaceTint = Theme.of(context).colorScheme.primary;
    return Scaffold(
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
              const SizedBox8(),
              _latestItemWidget(),
              SizedBox(height: height * 0.1),
              _myLatestLook(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _latestItemWidget() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.apply(
          color: titleColor,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.apply(
          color: subtitleColor,
        );
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    Widget latestItemMain(List<Item> last2Items) {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              shrinkWrap: true,
              children: List.generate(
                last2Items.length > 2 ? 2 : last2Items.length as int,
                (index) {
                  var brand = last2Items[index].brand ?? '';
                  if (brand.isEmpty) brand = 'No brand';
                  var name = last2Items[index].name ?? '';
                  if (name.isEmpty) name = 'No name';
                  return Column(
                    children: [
                      if (last2Items[index].imageData != null)
                        Image(
                          width: double.infinity,
                          height: height * 0.25,
                          image: MemoryImage(
                            last2Items[index].imageData!,
                          ),
                          fit: BoxFit.fill,
                        )
                      else
                        Container(),
                      Text(brand, style: textStyleTop),
                      Text(
                        name,
                        style: textStyleBottom,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.latestItemTitle,
                      style: titleStyle,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: titleColor,
                        ),
                        Text(
                          l10n.seeFavouriteItem,
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                //todo(jtl): add favourite screen and change route
                FloatingActionButton(
                  heroTag: 'itemProfile',
                  onPressed: () => AppNavigator.push<void>(
                    AppRoute.itemProfile,
                  ),
                  //   //   AppNavigator.push<void>(
                  //   // AppRoute.itemProfile,
                  // ),
                  child: const Icon(Icons.add),
                )
              ],
            ),
            const SizedBox(height: StyleConfig.defaultMargin),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                final last2Items = state.items.reversed.take(2).toList();
                if (state is ItemLoading) {
                  return const CustomLinearProgressIndicator();
                } else if (state is ItemLoaded) {
                  return latestItemMain(last2Items);
                } else if (state is ItemError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.itemLoadError)),
                  );
                  return latestItemMain(last2Items);
                }
                return latestItemMain(last2Items);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _myLatestLook() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.apply(
          color: titleColor,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.apply(
          color: subtitleColor,
        );
    final textStyleTop = Theme.of(context).textTheme.bodyLarge?.apply(
          color: titleColor,
        );
    final textStyleBottom = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    Widget latestItemMain(List<Item> last2Items) {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              shrinkWrap: true,
              children: List.generate(
                last2Items.length,
                (index) {
                  var brand = last2Items[index].brand ?? '';
                  if (brand.isEmpty) brand = 'No brand';
                  var name = last2Items[index].name ?? '';
                  if (name.isEmpty) name = 'No name';
                  return Column(
                    children: [
                      if (last2Items[index].imageData != null)
                        Image(
                          width: double.infinity,
                          height: height * 0.25,
                          image: MemoryImage(
                            last2Items[index].imageData!,
                          ),
                          fit: BoxFit.fill,
                        )
                      else
                        Container(),
                      Text(brand, style: textStyleTop),
                      Text(
                        name,
                        style: textStyleBottom,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: width,
      // height: height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.latestLookTitle,
                      style: titleStyle,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: titleColor,
                        ),
                        Text(
                          l10n.seeFavouriteLook,
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                //todo(jtl): add favourite screen and change route
                FloatingActionButton(
                  heroTag: 'looksScreen',
                  onPressed: () => AppNavigator.push<dynamic>(
                    AppRoute.itemProfile,
                  ),
                  child: const Icon(Icons.add),
                )
              ],
            ),
            const SizedBox(height: StyleConfig.defaultMargin),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                final last2Items = state.items.reversed.take(2).toList();
                if (state is ItemLoading) {
                  return const CustomLinearProgressIndicator();
                } else if (state is ItemLoaded) {
                  return latestItemMain(last2Items);
                } else if (state is ItemError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.itemLoadError)),
                  );
                  return latestItemMain(last2Items);
                }
                return latestItemMain(last2Items);
              },
            ),
          ],
        ),
      ),
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
    final l10n = context.l10n;
    final primaryColor = Theme.of(context).colorScheme.tertiary;
    final secondaryColor = Theme.of(context).colorScheme.onSurface;
    final textStyleTop = Theme.of(context)
        .textTheme
        .headlineLarge
        ?.copyWith(color: primaryColor);
    final textStyleBottom = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: secondaryColor,
        );
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.defaultPadding),
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoaded) {
            final itemCount = state.items.length;
            // count the total price of all items
            double totalValue = state.items
                .where((item) => item.price != null)
                .map((item) => item.price ?? 0.0)
                .fold(0, (total, price) => total + price);
            final looksCount = state.items
                .where((item) => item.looks != null)
                .expand((item) => item.looks!)
                .toSet()
                .length;
            final locale = Localizations.localeOf(context).toString();
            // TODO(jtl): need to fix automatic currency input without l13n package, can't separate US/UK
            // final format =
            //     NumberFormat.simpleCurrency(locale: locale.toString());
            final formatter = NumberFormat.currency(
              locale: locale,
              // TODO(jtl): need to fix automatic currency input without l13n package, can't separate US/UK
              // symbol: format.currencySymbol,
              symbol: l10n.currencySymbol,
              decimalDigits: 1,
            ).format(totalValue);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('$itemCount', style: textStyleTop),
                    Text(l10n.homeScreenLabelItems, style: textStyleBottom),
                  ],
                ),
                Column(
                  children: [
                    Text(formatter, style: textStyleTop),
                    Text(l10n.homeScreenLabelValue, style: textStyleBottom),
                  ],
                ),
                Column(
                  children: [
                    Text('$looksCount', style: textStyleTop),
                    Text(l10n.homeScreenLabelLooks, style: textStyleBottom),
                  ],
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
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
            return const CustomLinearProgressIndicator();
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
    WeatherLoaded state,
    BuildContext context,
    TextStyle? style,
  ) {
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
