class Config {
  // ******************************* URLS **************************************
  static const String baseUrl = 'http://192.168.1.104:8080/v1';
  static const String itemApiUrl = '$baseUrl/items';
  static const String lookApiUrl = '$baseUrl/looks';
  static const String weatherApiUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String removeBackgroundService =
      'http://192.168.1.104:8000/v1/remove-background';
  static const String baseLocation = 'London';
}
