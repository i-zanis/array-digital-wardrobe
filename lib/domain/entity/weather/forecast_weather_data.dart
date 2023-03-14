class ForecastWeatherData {
  ForecastWeatherData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.daily,
  });

  ForecastWeatherData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double;
    lon = json['lon'] as double;
    timezone = '';
    timezoneOffset = 0;
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  late double lat;
  late double lon;
  late String timezone;
  late int timezoneOffset;
  late List<Daily> daily;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    if (daily != null) {
      data['daily'] = daily.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  Daily(
      {required this.dt,
      required this.sunrise,
      required this.sunset,
      required this.moonrise,
      required this.moonset,
      required this.moonPhase,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.humidity,
      required this.dewPoint,
      required this.windSpeed,
      required this.windDeg,
      this.windGust,
      required this.weather,
      required this.clouds,
      required this.pop,
      required this.uvi,
      this.rain});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] as int;
    sunrise = 0;
    sunset = 0;
    moonrise = 0;
    moonset = 0;
    moonPhase = 0.0;
    temp = (json['temp'] != null
        ? Temp.fromJson(json['temp'] as Map<String, dynamic>)
        : null)!;
    feelsLike = (json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>)
        : null)!;
    pressure = 0;
    humidity = 0;
    dewPoint = 0;
    windSpeed = 0;
    windDeg = 0;
    windGust = 0.0;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v as Map<String, dynamic>));
      });
    }
    clouds = json['clouds'] as int;
    pop = 0.0;
    uvi = 0.0;
  }

  Daily.fromJson2(Map<String, dynamic> json) {
    dt = json['dt'] as int;
    sunrise = 0;
    sunset = 0;
    moonrise = 0;
    moonset = 0;
    moonPhase = 0.0;
    temp = (json['temp'] != null
        ? Temp.fromJson(json['temp'] as Map<String, dynamic>)
        : null)!;
    feelsLike = (json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>)
        : null)!;
    pressure = 0;
    humidity = 0;
    dewPoint = 0;
    windSpeed = 0;
    windDeg = 0;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v as Map<String, dynamic>));
      });
    }
    clouds = 0;
    pop = 0.0;
    uvi = 0.0;
  }

  late int dt;
  late int sunrise;
  late int sunset;
  late int moonrise;
  late int moonset;
  late double moonPhase;
  late Temp temp;
  late FeelsLike feelsLike;
  late int pressure;
  late int humidity;
  late double dewPoint;
  late double windSpeed;
  late int windDeg;
  double? windGust;
  late List<Weather> weather;
  late int clouds;
  late double pop;
  late double uvi;
  double? rain;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    if (temp != null) {
      data['temp'] = temp.toJson();
    }
    if (feelsLike != null) {
      data['feels_like'] = feelsLike.toJson();
    }
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['uvi'] = uvi;
    data['rain'] = rain;
    return data;
  }
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'] as double;
    min = 0.0;
    max = 0.0;
    night = 0.0;
    eve = 0.0;
    morn = 0.0;
  }

  late double day;
  late double min;
  late double max;
  late double night;
  late double eve;
  late double morn;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'] as double;
    night = json['night'] as double;
    eve = json['eve'] as double;
    morn = json['morn'] as double;
  }

  late double day;
  late double night;
  late double eve;
  late double morn;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    main = json['main'] as String;
    description = json['description'] as String;
    icon = json['icon'] as String;
  }

  late int id;
  late String main;
  late String description;
  late String icon;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
