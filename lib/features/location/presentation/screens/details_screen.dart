import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'package:tennis_app/features/weather/data/models/weather_info_model.dart';

class DetailsScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const DetailsScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required Map<String, dynamic> weatherData,
  });

  WeatherInfo getWeatherInfo(double temp) {
    if (temp >= 10 && temp < 15) {
      return WeatherInfo('assets/weather/storm.png', 'Rainy');
    } else if (temp >= 15 && temp < 20) {
      return WeatherInfo('assets/weather/cloud3.png', 'Mostly Cloudy');
    } else if (temp >= 20 && temp < 25) {
      return WeatherInfo('assets/weather/cloud1.png', 'Partly Cloudy');
    } else if (temp >= 25 && temp < 30) {
      return WeatherInfo('assets/weather/cloud2.png', 'Mostly Sunny');
    } else if (temp >= 30 && temp < 40) {
      return WeatherInfo('assets/weather/sun.png', 'Sunny');
    }
    return WeatherInfo('assets/weather/cloud1.png', 'Partly Cloudy');
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LocationError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is LocationLoaded) {
          final weatherData = state.weatherData;
          final forecast = state.forecast;

          final cityName = weatherData['location']['name'];
          final tempC = weatherData['current']['temp_c'];
          final humidity = weatherData['current']['humidity'];
          final windKph = weatherData['current']['wind_kph'];
          final cloud = weatherData['current']['cloud'];

          final weatherInfo = getWeatherInfo(tempC);
          final String currentDate =
              DateFormat('dd MMM yyyy').format(DateTime.now());
          final String currentTime =
              DateFormat('hh:mm a').format(DateTime.now());

          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 0, 33, 60),
              body: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              _capitalizeFirstLetter(cityName),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              weatherInfo.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 30,
                                    top: 25,
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Image.asset(
                                        weatherInfo.imagePath,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${tempC.toInt()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 150,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$currentDate at $currentTime',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 350,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.water_drop,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '$humidity%',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const Text(
                                        'Humidity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.air,
                                        color: Colors.orange,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '$windKph kph',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const Text(
                                        'Wind Speed',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cloud,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '$cloud%',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const Text(
                                        'Cloud Cover',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 350,
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: forecast.length,
                                itemBuilder: (context, index) {
                                  final forecastDay = forecast[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Container(
                                      height: 90,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey.withOpacity(0.7),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            weatherInfo.imagePath,
                                            height: 40,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            DateFormat('EEE').format(
                                                DateTime.parse(
                                                    forecastDay.date)),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${forecastDay.temperature.toInt().toString()}°',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            weatherInfo.description,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 33, 60),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ]))));
        }
        return const Center(child: Text('Press the button to get location.'));
      },
    );
  }
}
