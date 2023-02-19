class Clouds {
  Clouds({required this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'] as int;
  }
  late int all;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}
