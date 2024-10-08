import 'package:tennis_app/core/utils/daily_forecast.dart';


abstract class WeatherDataSource {
  Future<Map<String, dynamic>> getCurrentWeather(String city);
  Future<List<DailyForecast>> getForecastWeather(String city);
}