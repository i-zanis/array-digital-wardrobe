class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] as double;
    lat = json['lat'] as double;
  }

  late double lon;
  late double lat;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
