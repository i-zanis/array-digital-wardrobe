import 'package:Array_App/domain/entity/weather/current_weather_data.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherData> getWeather(String city);
}
