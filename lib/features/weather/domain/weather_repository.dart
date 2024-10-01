abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeather(
    String city,
  );
}
