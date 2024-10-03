import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'package:tennis_app/features/location/presentation/screens/details_screen.dart';
import 'package:tennis_app/features/weather/presentation/screens/weather_screen.dart'; 

class LocationWeatherScreen extends StatefulWidget {
  const LocationWeatherScreen(
      {super.key, required double latitude, required double longitude});

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends State<LocationWeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/world_map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 8, left: 8, bottom: 0),
          child: Column(
            children: [
              const Text(
                'Search For City',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            hintText: 'Location',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 33, 60)),
                            prefixIcon: Icon(Icons.search,
                                color: Color.fromARGB(255, 0, 33, 60)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 33, 60)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        final cityName = _cityController.text.trim();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherScreen(city: cityName),
                          ),
                        );
                        _cityController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        backgroundColor: Colors.grey.withOpacity(0.7),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Get Weather',
                        style: TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocListener<LocationBloc, LocationState>(
                listener: (context, state) {
                  if (state is LocationLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          latitude: state.position.latitude,
                          longitude: state.position.longitude,
                          weatherData: state.weatherData,
                        ),
                      ),
                    );
                  } else if (state is LocationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LocationBloc>(context)
                          .add(GetLocationEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(90),
                            topRight: Radius.circular(90)),
                      ),
                    ),
                    child: const Text(
                      'Get Weather For Current Location',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 33, 60),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
