import 'package:tennis_app/core/utils/daily_forecast.dart';

import 'package:tennis_app/features/weather/domain/weather_repository.dart';

class ForecastWeatherUseCase {
  final WeatherRepository weatherRepository;

  ForecastWeatherUseCase(this.weatherRepository);

  Future<List<DailyForecast>> execute(String city) {
    return weatherRepository.getForecastWeather(city);
  }
}