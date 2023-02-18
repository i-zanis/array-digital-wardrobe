class WeatherUseCaseException implements Exception {
  WeatherUseCaseException(this.message);

  final String message;
}
