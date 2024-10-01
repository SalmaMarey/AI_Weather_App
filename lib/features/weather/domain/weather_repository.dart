import 'package:tennis_app/features/location/data/models/weather_data_model.dart';

abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeather(
    String city,
  );
    Future<WeatherData> getWeatherByCoordinates(double latitude, double longitude);
}