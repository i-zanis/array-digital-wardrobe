import 'package:Array_App/data/repository/weather_repository_impl.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:Array_App/domain/exception/exception.dart';
import 'package:Array_App/domain/repository/weather_repository.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';

class LoadWeatherUseCase implements UseCase<CurrentWeatherData, String> {
  LoadWeatherUseCase({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepositoryImpl();

  final WeatherRepository _weatherRepository;

  @override
  Future<CurrentWeatherData> execute(String city) async {
    logger.i('$LoadWeatherUseCase execute city: $city');
    if (await validate(city)) {
      return _weatherRepository.findWeatherDataByCity(city);
    }
    return Future.error(WeatherUseCaseException('Invalid city name'));
  }

  @override
  Future<bool> validate(String city) async {
    final sanitizedCity = city.trim();
    if (sanitizedCity.isEmpty) {
      throw WeatherUseCaseException("City name can't be empty");
    }
    if (_isInvalidCityName(sanitizedCity)) {
      throw WeatherUseCaseException('City name contains invalid characters');
    }
    if (_isInvalidCityNameLength(sanitizedCity)) {
      throw WeatherUseCaseException(
        'City name should be between 2 and 60 characters',
      );
    }
    return true;
  }

  bool _isInvalidCityName(String value) {
    // r == raw string
    return !RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  bool _isInvalidCityNameLength(String cityName) {
    return cityName.isEmpty || cityName.length > 60;
  }
}
