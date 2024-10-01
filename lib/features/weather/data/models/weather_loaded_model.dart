import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_state.dart';

class WeatherLoaded extends WeatherState {
  final String city;
  final double temperature;
  final double windKph;
  final int humidity;
  final int cloud;
  final List<DailyForecast> forecast;

  WeatherLoaded({
    required this.city,
    required this.temperature,
    required this.windKph,
    required this.humidity,
    required this.cloud,
    required this.forecast,
  });
}
