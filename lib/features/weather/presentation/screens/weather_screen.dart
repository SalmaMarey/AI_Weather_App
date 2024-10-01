import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/features/weather/data/models/weather_info_model.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_bloc.dart';
import '../controllers/weather_bloc/weather_event.dart';
import '../controllers/weather_bloc/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({super.key, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherEvent(widget.city));
  }

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
    final String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    final String currentTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 33, 60),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weatherInfo = getWeatherInfo(state.temperature);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(_capitalizeFirstLetter(widget.city),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
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
                            '${state.temperature.toInt()}°',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 150,
                                fontWeight: FontWeight.bold),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                '${state.humidity}%',
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
                                '${state.windKph} kph',
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
                                '${state.cloud}%',
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
                        itemCount: state.forecast.length,
                        itemBuilder: (context, index) {
                          final forecast = state.forecast[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              height: 90,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    weatherInfo.imagePath,
                                    height: 40,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    DateFormat('EEE')
                                        .format(DateTime.parse(forecast.date)),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${forecast.temperature.toInt()}°',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    forecast.weatherCondition,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 33, 60),
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
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No weather data available.'));
        },
      ),
    );
  }
}
