import 'dart:async';
import 'dart:developer';

import 'package:Array_App/bloc/bloc.dart';
import 'package:Array_App/domain/use_case/load_weather_data_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search/search_cubit.dart';
import 'bloc/weather/weather_event.dart';
import 'domain/use_case/initial_load_use_case.dart';
import 'domain/use_case/item/add_item_use_case.dart';
import 'domain/use_case/item/delete_item_use_case.dart';
import 'domain/use_case/item/update_item_use_case.dart';
import 'main_development.dart';

class AppBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
//     super.onChange(bloc, change);
//     log('onChange(${bloc.runtimeType}, $change)');
//   }
//
//   @override
//   void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
//     log('onError(${bloc.runtimeType}, $error, $stackTrace)');
//     super.onError(bloc, error, stackTrace);
//   }
//
//   @override
//   void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
//     super.onEvent(bloc, event);
//     log('onEvent $event');
//   }
//
//   @override
//   void onTransition(
//     Bloc<dynamic, dynamic> bloc,
//     Transition<dynamic, dynamic> transition,
//   ) {
//     super.onTransition(bloc, transition);
//     log('onTransition $transition');
//   }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  logger.i('Bootstrap Loaded..');
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  final app = MultiBlocProvider(
    providers: [
      BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(
          InitialLoadUseCase(),
          SaveItemUseCase(),
          DeleteItemUseCase(),
          UpdateItemUseCase(),
        )..add(const LoadItem()),
      ),
      BlocProvider<WeatherBloc>(
        create: (context) =>
            WeatherBloc(LoadWeatherUseCase())..add(const LoadWeather()),
      ),
      BlocProvider<SearchCubit>(
        create: (BuildContext context) => SearchCubit(context.read<ItemBloc>()),
      ),
    ],
    child: await builder(),
  );

  await runZonedGuarded(
    () async => runApp(app),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
