class Wind {
  Wind({required this.speed, required this.deg, required this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] * 1.0 as double;
    deg = 0;
    gust = 0;
  }
  late double speed;
  late int deg;
  late double gust;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}
