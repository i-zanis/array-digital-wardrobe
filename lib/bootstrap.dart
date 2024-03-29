import 'dart:async';
import 'dart:developer';

import 'package:Array_App/bloc/bloc.dart';
import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/bloc/search/item_search_cubit.dart';
import 'package:Array_App/bloc/search/look_search_cubit.dart';
import 'package:Array_App/bloc/weather/weather_event.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          InitialItemLoadUseCase(),
          InitialLookLoadUseCase(),
          SaveItemUseCase(),
          DeleteItemUseCase(),
          UpdateItemUseCase(),
          SaveLookUseCase(),
          UpdateLookUseCase(),
          RemoveBackgroundUseCase(),
        )..add(const LoadItem()),
      ),
      BlocProvider<WeatherBloc>(
        create: (context) =>
            WeatherBloc(LoadWeatherUseCase())..add(const LoadWeather()),
      ),
      BlocProvider<ItemSearchCubit>(
        create: (BuildContext context) =>
            ItemSearchCubit(context.read<ItemBloc>()),
      ),
      BlocProvider<LookSearchCubit>(
        create: (BuildContext context) =>
            LookSearchCubit(context.read<ItemBloc>()),
      ),
      BlocProvider<MixAndMatchCubit>(
        create: (BuildContext context) => MixAndMatchCubit(),
      ),
    ],
    child: await builder(),
  );

  await runZonedGuarded(
    () async => runApp(app),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
