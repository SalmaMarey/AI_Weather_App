import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

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

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}