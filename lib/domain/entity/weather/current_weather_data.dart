import 'package:Array_App/domain/entity/weather/clouds.dart';
import 'package:Array_App/domain/entity/weather/coord.dart';
import 'package:Array_App/domain/entity/weather/forecast_weather_data.dart';
import 'package:Array_App/domain/entity/weather/main_weather.dart';
import 'package:Array_App/domain/entity/weather/sys.dart';
import 'package:Array_App/domain/entity/weather/wind.dart';

class CurrentWeatherData {
  CurrentWeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null
        ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
        : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v as Map<String, dynamic>));
      });
    }
    base = '';
    main = json['main'] != null
        ? Main.fromJson(json['main'] as Map<String, dynamic>)
        : null;
    visibility = 0;
    wind = json['wind'] != null
        ? Wind.fromJson(json['wind'] as Map<String, dynamic>)
        : null;
    clouds = json['clouds'] != null
        ? Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
        : null;
    dt = json['dt'] as int;
    sys = json['sys'] != null
        ? Sys.fromJson(json['sys'] as Map<String, dynamic>)
        : null;
    timezone = 0;
    id = 0;
    name = json['name'] as String;
    cod = json['cod'] as int;
  }

  late Coord? coord;
  late List<Weather>? weather;
  late String? base;
  late Main? main;
  late int? visibility;
  late Wind? wind;
  late Clouds? clouds;
  late int? dt;
  late Sys? sys;
  late int? timezone;
  late int? id;
  late String? name;
  late int? cod;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    final coord = this.coord;
    if (coord != null) {
      data['coord'] = coord.toJson();
    }
    final weather = this.weather;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    data['base'] = base;
    final main = this.main;
    if (main != null) {
      data['main'] = main.toJson();
    }
    data['visibility'] = visibility;
    final wind = this.wind;
    if (wind != null) {
      data['wind'] = wind.toJson();
    }
    final clouds = this.clouds;
    if (clouds != null) {
      data['clouds'] = clouds.toJson();
    }
    data['dt'] = dt;
    final sys = this.sys;
    if (sys != null) {
      data['sys'] = sys.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}
