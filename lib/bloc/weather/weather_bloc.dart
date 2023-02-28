import 'package:Array_App/bloc/weather/weather_event.dart';
import 'package:Array_App/bloc/weather/weather_state.dart';
import 'package:Array_App/domain/use_case/load_weather_data_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(
    this._loadWeatherUseCase,
  ) : super(const WeatherState.initial()) {
    on<LoadWeather>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  final LoadWeatherUseCase _loadWeatherUseCase;

  Future<void> _onLoadStarted(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading(data: state.data));
      final data = await _loadWeatherUseCase.execute(state.location);
      emit(WeatherLoaded(data: data));
    } on Exception catch (e) {
      emit(const WeatherLoadFailure());
    }
  }
}
