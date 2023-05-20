import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/bloc/weather/weather_bloc.dart';
import 'package:Array_App/bloc/weather/weather_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/main_development.dart';
import 'package:Array_App/presentation/widget/look_grid_view.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool useLightMode = true;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(Styles.borderRadiusS),
    );
    final surface = Theme.of(context).colorScheme.surface;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final surfaceTint = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultMargin),
          child: Column(
            children: [
              Box.h16,
              _greetingSection(),
              Box.h16,
              _weatherSection(),
              Box.h16,
              _bodyMeasurementSection(
                borderRadius,
                shadowColor,
                surfaceTint,
                surface,
              ),
              Box.h32,
              _dataRowSection(),
              Box.h32,
              _latestItemSection(),
              Box.h32,
              _latestLookSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _latestItemSection() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    // change opacity color
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: titleColor,
          fontWeight: FontWeight.bold,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleMedium?.apply(
          color: subtitleColor,
        );
    return SizedBox(
      width: width,
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
                  Box.h4,
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: subtitleColor,
                        ),
                        Box.w4,
                        Text(
                          l10n.seeFavouriteItem,
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                    // TODO(jtl): fix tap method
                    onTap: () =>
                        AppNavigator.push<dynamic>(AppRoute.itemProfile),
                  ),
                ],
              ),
              const Spacer(),
              PlusButton(
                heroTag: l10n.itemProfileScreenTitle,
                onPressed: () => AppNavigator.push<dynamic>(AppRoute.camera),
              ),
            ],
          ),
          Box.h8,
          const ItemGridView(numOfItemsToShow: 2)
        ],
      ),
    );
  }

  Widget _latestLookSection() {
    final l10n = context.l10n;
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = Theme.of(context).colorScheme.onSurface;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: titleColor,
          fontWeight: FontWeight.bold,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.apply(
          color: subtitleColor,
        );
    return SizedBox(
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
                  Box.h4,
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: subtitleColor,
                        ),
                        Box.w4,
                        Text(
                          l10n.seeFavouriteLook,
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                    // TODO(jtl): fix tap method
                    onTap: () =>
                        AppNavigator.push<dynamic>(AppRoute.selectItemInGrid),
                  ),
                ],
              ),
              const Spacer(),
              //todo(jtl): add favourite screen and change route
              PlusButton(
                onPressed: () => {
                  AppNavigator.push<void>(
                    AppRoute.selectItemInGrid,
                  ),
                },
                heroTag: l10n.lookBookScreenTitle,
              ),
            ],
          ),
          Box.h8,
          const LookGridView()
        ],
      ),
    );
  }

  Widget _bodyMeasurementSection(
    BorderRadius borderRadius,
    Color shadowColor,
    Color surfaceTint,
    Color surface,
  ) {
    final widgetPrimaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.apply(color: widgetPrimaryColor);
    return Material(
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTint,
      color: surface,
      type: MaterialType.card,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(Styles.defaultMargin),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Box.h16,
              Icon(
                Icons.accessibility_new,
                size: 40,
                color: widgetPrimaryColor,
              ),
              Box.h24,
              Padding(
                padding: const EdgeInsets.all(Styles.marginS),
                child: Text(
                  context.l10n.bodyMeasurement,
                  style: textStyle,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, color: widgetPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _greetingSection() {
    final l10n = context.l10n;
    return Row(
      children: [
        const Spacer(),
        Text(
          l10n.homeScreenGreeting,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.apply(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(width: Styles.defaultMargin),
        Text(
          // TODO(jtl): add name user name from bloc
          'Emily!',
          style: Theme.of(context).textTheme.displaySmall?.apply(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const Spacer(),
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/images/profile-pic.jpg'),
        ),
        // IconButton(
        //   icon: useLightMode
        //       ? const Icon(Icons.wb_sunny_outlined)
        //       : const Icon(Icons.wb_sunny),
        //   onPressed: handleBrightnessChange,
        //   tooltip: "Toggle brightness",
        // ),
      ],
    );
  }

  Widget _dataRowSection() {
    final l10n = context.l10n;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.primary;
    final textStyleTop = Theme.of(context)
        .textTheme
        .headlineLarge
        ?.copyWith(color: primaryColor);
    final textStyleBottom =
        Theme.of(context).textTheme.titleMedium?.apply(color: secondaryColor);
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoaded) {
          final itemCount = state.items.length;
          // count the total price of all items
          final totalValue = state.items
              .where((item) => item.price != null)
              .map((item) => item.price ?? 0.0)
              .fold(0, (total, price) => (total + price).toInt());
          final looksCount = state.looks
              // .where((item) => item.looks != null)
              // .expand((item) => item.looks!)
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
    );
  }

  Widget _weatherSection() {
    final l10n = context.l10n;
    final date = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMM d', l10n.locale).format(date);
    final widgetPrimaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyleFirstRow = Theme.of(context)
        .textTheme
        .titleMedium
        ?.apply(color: widgetPrimaryColor);
    final textStyleSecondRow = Theme.of(context)
        .textTheme
        .labelSmall
        ?.apply(color: widgetPrimaryColor);
    const borderRadius = BorderRadius.all(
      Radius.circular(Styles.borderRadiusS),
    );
    final surface = Theme.of(context).colorScheme.surface;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final surfaceTint = Theme.of(context).colorScheme.primary;

    final textStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: widgetPrimaryColor,
        );
    return Material(
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTint,
      color: surface,
      type: MaterialType.card,
      elevation: 2,
      child: SizedBox(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const CustomLinearProgressIndicator();
            } else if (state is WeatherLoaded) {
              return Padding(
                padding: const EdgeInsets.all(Styles.defaultMargin),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Box.h16,
                        _getWeatherIcon(state, widgetPrimaryColor),
                        Box.h16,
                        Padding(
                          padding: const EdgeInsets.all(Styles.marginS),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedDate,
                                style: textStyleFirstRow,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _getDateTemp(
                                      state, context, textStyleSecondRow),
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
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is WeatherError) {
              showSnackBar(context, l10n.homeScreenWeatherError);
            }
          },
        ),
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

  void handleBrightnessChange() {
    setState(() {
      useLightMode = !useLightMode;
      logger.i(useLightMode.toString());
      themeData = updateThemes(useLightMode);
    });
  }

  ThemeData updateThemes(bool useLightMode) {
    logger.i('Updating theme to ${useLightMode ? 'light' : 'dark'} mode');
    return ThemeData(
        useMaterial3: true,
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }
}
