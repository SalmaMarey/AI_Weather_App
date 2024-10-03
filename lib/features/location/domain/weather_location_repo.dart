import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final String apiKey = 'e50b199406a3442d8dd232306243009';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final String url = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getForecast(String city) async {
    final String url = 'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}

