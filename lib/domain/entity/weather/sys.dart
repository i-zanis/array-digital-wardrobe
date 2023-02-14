class Sys {
  Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'] as int;
    id = json['id'] as int;
    country = json['country'] as String;
    sunrise = getClockInUtcPlus3Hours(json['sunrise'] as int);
    sunset = getClockInUtcPlus3Hours(json['sunset'] as int);
  }

  late int type;
  late int id;
  late String country;
  late String sunrise;
  late String sunset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }

  String getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
            isUtc: true)
        .add(const Duration(hours: 3));
    return '${time.hour}:${time.second}';
  }
}
