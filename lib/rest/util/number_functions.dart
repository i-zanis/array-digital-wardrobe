import 'package:Array_App/main_development.dart';

// Convert a value to a double, or return a default value
double parseToDoubleOrDefault(dynamic value, [double defaultValue = 0.0]) {
  if (value is num) {
    return value.toDouble();
  } else if (value is String) {
    logger.e('parseToDoubleOrDefault: value is String: $value');
    return double.tryParse(value) ?? defaultValue;
  } else {
    return defaultValue;
  }
}
