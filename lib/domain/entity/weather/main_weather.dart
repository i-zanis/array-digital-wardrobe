class Main {
  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] as double;
    feelsLike = json['feels_like'] as double;
    tempMin = json['temp_min'] as double;
    tempMax = json['temp_max'] as double;
    pressure = json['pressure'] as int;
    humidity = json['humidity'] as int;
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
