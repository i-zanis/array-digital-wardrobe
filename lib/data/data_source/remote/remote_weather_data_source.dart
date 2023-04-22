import 'package:Array_App/config/config.dart';
import 'package:Array_App/data/network/network_client_factory.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../network/network_client.dart';

class RemoteWeatherDataSource {
  RemoteWeatherDataSource({NetworkClient? client, String? baseUrl})
      : _client = client ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.weatherApiUrl;

  final NetworkClient _client;
  final String _baseUrl;

  Future<CurrentWeatherData> findWeatherDataByCity(String city) async {
    logger.i('$RemoteWeatherDataSource: getWeatherData($city)');
    final response = await _client.get(
      "$_baseUrl?q=$city,uk&appid=${dotenv.env['OPEN_WEATHER_MAP_API_KEY']}",
    );
    logger.d(
      '$RemoteWeatherDataSource: getWeatherData($city) response: $response',
    );
    return CurrentWeatherData.fromJson(response.data as Map<String, dynamic>);
  }
}
