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
