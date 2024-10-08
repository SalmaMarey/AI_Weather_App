
import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';

abstract class WeatherDataSource {
  Future<Map<String, dynamic>> getCurrentWeather(String city);
  Future<List<DailyForecast>> getForecastWeather(String city);
}