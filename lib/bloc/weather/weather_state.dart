import 'package:Array_App/config/config.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState({this.data, this.location = Config.baseLocation});

  const WeatherState._({this.data, this.location = Config.baseLocation});

  const WeatherState.initial() : this._();

  final CurrentWeatherData? data;
  final String location;

  @override
  List<Object?> get props => [data, location];

  WeatherState copyWith({
    CurrentWeatherData? data,
  }) {
    return WeatherState(
      data: data ?? this.data,
      location: location,
    );
  }
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded({required super.data}) : super._();
}

class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading({required super.data}) : super._();
}

class WeatherError extends WeatherState {
  const WeatherError();
}
