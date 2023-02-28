import 'package:flutter/material.dart';

// Maps the weather condition to the corresponding icon
// See https://openweathermap.org/weather-conditions
class WeatherIcon {
  static IconData mapToIcon(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'rain':
        return Icons.beach_access;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'snow':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.thunderstorm;
      default:
        return Icons.error;
    }
  }
}
