import 'package:http/http.dart' as http;
import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';
import 'dart:convert';
import 'package:tennis_app/features/weather/domain/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final String apiKey = 'e50b199406a3442d8dd232306243009';

  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city'),
    );

    if (response.statusCode == 200) {
      final currentData = jsonDecode(response.body);
      return currentData['current'];
    } else {
      throw Exception('Failed to load current weather data: ${response.body}');
    }
  }

  Future<List<DailyForecast>> getForecastWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7'),
    );

    // print('Request URL: ${response.request?.url}');
    // print('Response Status: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> weatherData = jsonDecode(response.body);
      final List<dynamic> forecastData = weatherData['forecast']['forecastday'];

      // print('Forecast Data: ${jsonEncode(forecastData)}');
      // assert(forecastData is List);

      final List<DailyForecast> forecast = forecastData.map((day) {
        return DailyForecast(
          date: day['date'],
          temperature: day['day']['avgtemp_c'].toDouble(),
          weatherCondition: day['day']['condition']['text'],
          imagePath:
              'assets/weather/${day['day']['condition']['icon'].split('/').last}',
        );
      }).toList();

      return forecast;
    } else {
      throw Exception('Failed to load forecast data: ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> getWeather(String city) async {
    try {
      final currentWeather = await getCurrentWeather(city);
      final forecastWeather = await getForecastWeather(city);

      // print('Current Weather: $currentWeather');
      // print('Forecast Weather: $forecastWeather');

      final combinedData = {
        'current': currentWeather,
        'forecast': forecastWeather,
      };

      return combinedData;
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
