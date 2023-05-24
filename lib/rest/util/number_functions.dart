/// Convert a value to a double, or return a default value
double parseToDoubleOrDefault(dynamic value, [double defaultValue = 0.0]) {
  if (value is num) {
    return value.toDouble();
  } else if (value is String) {
    return double.tryParse(value) ?? defaultValue;
  } else {
    return defaultValue;
  }
}

/// Convert a value to an int, or return a default value
int parseToIntOrDefault(dynamic value, [int defaultValue = 0]) {
  if (value is num) {
    return value.toInt();
  } else if (value is String) {
    return int.tryParse(value) ?? defaultValue;
  } else {
    return defaultValue;
  }
}
