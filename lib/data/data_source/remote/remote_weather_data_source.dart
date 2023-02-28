import 'dart:convert';

import 'package:Array_App/config/config.dart';
import 'package:Array_App/domain/entity/weather/current_weather_data.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../network/network_client.dart';
import '../../network/network_client_factory.dart';

class RemoteWeatherDataSource {
  RemoteWeatherDataSource({NetworkClient? client, String? baseUrl})
      : _client = client ?? NetworkClientFactory.create(),
        _baseUrl = baseUrl ?? Config.weatherUrl;

  final NetworkClient _client;
  final String _baseUrl;

  Future<CurrentWeatherData> getWeatherData(String city) async {
    logger.i('$RemoteWeatherDataSource: getWeatherData($city)');
    final response = await _client.get(
      "$_baseUrl?q=$city,uk&appid=${dotenv.env['OPEN_WEATHER_MAP_API_KEY']}",
    );
    logger.i(
      '$RemoteWeatherDataSource: getWeatherData($city) response: $response',
    );
    final json = await jsonDecode(jsonEncode(response.data));
    return CurrentWeatherData.fromJson(json as Map<String, dynamic>);
  }
}
