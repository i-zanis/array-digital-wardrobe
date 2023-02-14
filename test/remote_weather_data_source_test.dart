import 'package:Array_App/data/source/remote/remote_weather_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final remoteWeatherDataSource = RemoteWeatherDataSource(networkClient: Dio());
  await dotenv.load();
  test('test getWeatherData', () async {
    final weatherData = await remoteWeatherDataSource.getWeatherData('London');
    expect(weatherData, isNotNull);
  });
}
