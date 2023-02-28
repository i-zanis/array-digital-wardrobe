/// Returns True if the [lastFetched] is older than the [timeToLive].
bool isStale(DateTime lastFetched, Duration timeToLive) {
  return lastFetched.add(timeToLive).isBefore(DateTime.now());
}

/// Returns the [kelvin] temperature as a Celsius temperature.
double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

/// Returns the [kelvin] temperature as a Fahrenheit temperature.
double kelvinToFahrenheit(double kelvin) {
  return kelvin * 9 / 5 - 459.67;
}
