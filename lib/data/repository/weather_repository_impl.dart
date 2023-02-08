import 'package:Array_App/data/source/remote/remote_weather_data_source.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';

import '../../domain/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  factory WeatherRepositoryImpl() {
    return _singleton;
  }

  WeatherRepositoryImpl._internal()
      : _remoteDataSource = RemoteWeatherDataSource();
  static final WeatherRepositoryImpl _singleton =
      WeatherRepositoryImpl._internal();

  final RemoteWeatherDataSource _remoteDataSource;
  final Duration _timeToLive = const Duration(seconds: 5);
  DateTime _lastUpdate = DateTime(0);

  @override
  Future<CurrentWeatherData> getWeather(String city) {
    if (_isStale()) {
      _lastUpdate = DateTime.now();
      return _remoteDataSource.getWeatherData(city);
    }
    return Future.value(CurrentWeatherData());
  }

  bool _isStale() {
    return DateTime.now().difference(_lastUpdate) > _timeToLive;
  }
}
