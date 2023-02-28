import 'package:Array_App/data/data_source/remote/remote_weather_data_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final remoteWeatherDataSource = RemoteWeatherDataSource();
  await dotenv.load();
  test('test getWeatherData', () async {
    final weatherData = await remoteWeatherDataSource.getWeatherData('London');
    expect(weatherData, isNotNull);
  });
}
