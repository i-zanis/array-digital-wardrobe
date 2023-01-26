class Preferences {
  Preferences({required this.location});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['location'] = location;
    return data;
  }

  String location;
}
