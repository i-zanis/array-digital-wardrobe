import 'package:Array_App/data/repository/weather_repository_impl.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:Array_App/domain/exception/weather_exception.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/domain/weather_repository.dart';
import 'package:Array_App/main_development.dart';

class LoadWeatherUseCase implements UseCase<CurrentWeatherData, String> {
  LoadWeatherUseCase({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepositoryImpl();

  final WeatherRepository _weatherRepository;

  @override
  Future<CurrentWeatherData> execute(String city) async {
    logger.i('$LoadWeatherUseCase execute city: $city');
    if (await validate(city)) return _weatherRepository.getWeather(city);
    return Future.error(WeatherUseCaseException("City name can't be empty"));
  }

  @override
  Future<bool> validate(String city) async {
    if (city.trim().isEmpty) {
      throw WeatherUseCaseException("City name can't be empty");
    }
    if (!isValidString(city)) {
      throw WeatherUseCaseException('City name contains invalid characters');
    }
    return true;
  }

  bool isValidString(String value) {
    // r == raw string
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }
}
