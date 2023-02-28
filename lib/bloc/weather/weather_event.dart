import 'package:Array_App/config/config.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class LoadWeather extends WeatherEvent {
  const LoadWeather({this.data, this.location = Config.baseLocation});

  final CurrentWeatherData? data;
  final String location;

  @override
  List<Object?> get props => [data, location];
}
