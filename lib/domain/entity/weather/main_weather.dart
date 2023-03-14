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
    // "as double" doesn't always therefore * 1.0 is needed
    temp = (json['temp'] ?? 0.0) * 1.0 as double;
    feelsLike = (json['feels_like'] ?? 0.0) as double;
    tempMin = (json['temp_min'] ?? 0.0) * 1.0 as double;
    tempMax = (json['temp_max'] ?? 0.0) * 1.0 as double;
    pressure = (json['pressure'] ?? 0) as int;
    humidity = (json['humidity'] ?? 0) as int;
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
