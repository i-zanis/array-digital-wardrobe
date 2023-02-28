import 'package:Array_App/domain/entity/base_entity.dart';

class Preferences extends BaseEntity {
  Preferences({
    super.id,
    this.location = 'London',
    this.isDarkMode = false,
    this.isMetric = false,
    this.isNotificationsEnabled = false,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      id: json['id'] as int,
      location: json['location'] as String,
      isDarkMode: json['isDarkMode'] as bool,
      isMetric: json['isMetric'] as bool,
      isNotificationsEnabled: json['isNotificationsEnabled'] as bool,
    );
  }

  String location;
  bool isDarkMode;
  bool isMetric;
  bool isNotificationsEnabled;

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'isDarkMode': isDarkMode,
      'isMetric': isMetric,
      'isNotificationsEnabled': isNotificationsEnabled,
    };
  }
}
