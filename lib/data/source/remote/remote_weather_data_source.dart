import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../config/config.dart';
import '../../../domain/entity/weather/current_weather_data.dart';

class RemoteWeatherDataSource {
  RemoteWeatherDataSource({Dio? networkClient, String? baseUrl})
      : networkClient = networkClient ?? Dio(),
        _baseUrl = baseUrl ?? Config.baseUrl;

  final Dio networkClient;
  final String _baseUrl;

  Future<dynamic> getWeatherData(String city) async {
    final response = await networkClient.get(
      "$_baseUrl?q=$city,uk&appid=${dotenv.env['OPEN_WEATHER_MAP_API_KEY']}",
    );
    final json = await jsonDecode(response.data.toString());
    return CurrentWeatherData.fromJson(json as Map<String, dynamic>);
  }
}
