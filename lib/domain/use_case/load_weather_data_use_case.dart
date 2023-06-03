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
    final sanitizedCity = city.trim();
    await validate(sanitizedCity);
    return _weatherRepository.findWeatherDataByCity(city);
  }

  @override
  Future<void> validate(String city) async {
    if (city.isEmpty) {
      throw WeatherUseCaseException(message: "City name can't be empty");
    }
    if (_isInvalidCityName(city)) {
      throw WeatherUseCaseException(
        message: 'City name contains invalid characters',
      );
    }
    if (_isInvalidCityNameLength(city)) {
      throw WeatherUseCaseException(
        message: 'City name should be between 2 and 60 characters',
      );
    }
  }

  bool _isInvalidCityName(String city) {
    // r == raw string
    return !RegExp(r'^[a-zA-Z]+$').hasMatch(city);
  }

  bool _isInvalidCityNameLength(String cityName) {
    return cityName.length < 2 || cityName.length > 60;
  }
}
