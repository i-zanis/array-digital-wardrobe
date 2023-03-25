import 'package:Array_App/rest/util/number_functions.dart';

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = parseToDoubleOrDefault(json['temp']);
    feelsLike = parseToDoubleOrDefault(json['feels_like']);
    tempMin = parseToDoubleOrDefault(json['temp_min']);
    tempMax = parseToDoubleOrDefault(json['temp_max']);
    pressure = json['pressure'] as int? ?? 0;
    humidity = json['humidity'] as int? ?? 0;
  }

  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int humidity;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}
