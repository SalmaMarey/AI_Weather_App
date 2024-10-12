import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/core/models/weather_info_helper.dart';
import 'package:tennis_app/features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'package:tennis_app/features/location/presentation/widgets/forecast_widget.dart';
import 'package:tennis_app/features/location/presentation/widgets/weather_statistics_widget.dart';

class DetailsScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final String? cityName;
  final Map<String, dynamic>? weatherData;

  const DetailsScreen({
    super.key,
    this.latitude,
    this.longitude,
    this.cityName,
    this.weatherData,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.cityName != null && widget.cityName!.isNotEmpty) {
      BlocProvider.of<LocationBloc>(context)
          .add(GetLocationEvent(cityName: widget.cityName!));
    } else {
      BlocProvider.of<LocationBloc>(context)
          .add(GetLocationEvent(cityName: ''));
    }
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
          return Center(
            child: Text('Error: ${state.error.toString()}'),
          );
        } else if (state is LocationLoaded) {
          final currentWeatherData = widget.weatherData ?? state.weatherData;
          final forecast = state.forecast;
          final cityName = currentWeatherData['location']['name'];
          final tempC = currentWeatherData['current']['temp_c'];
          final humidity =
              (currentWeatherData['current']['humidity'] as num).toDouble();
          final windKph =
              (currentWeatherData['current']['wind_kph'] as num).toDouble();
          final cloud =
              (currentWeatherData['current']['cloud'] as num).toDouble();
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
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 350,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: WeatherStatisticsWidget(
                        humidity: humidity,
                        windKph: windKph,
                        cloud: cloud,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ForecastWidget(forecast: forecast),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: Text('Failed to load data'));
      },
    );
  }
}
