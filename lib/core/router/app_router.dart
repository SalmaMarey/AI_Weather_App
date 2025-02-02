import 'package:flutter/material.dart';
import 'package:tennis_app/features/location/presentation/screens/details_screen.dart';
import 'package:tennis_app/features/location/presentation/screens/location_weather_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/locationweather':
        if (args is Map<String, double>) {
          return MaterialPageRoute(
            builder: (_) => LocationWeatherScreen(
              latitude: args['latitude']!,
              longitude: args['longitude']!,
            ),
          );
        }
        return _errorRoute();
      case '/details':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(
              cityName: args['cityName'], 
              latitude: args['latitude'],
              longitude: args['longitude'],
              weatherData: args['weatherData'],
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found")),
      ),
    );
  }
}
