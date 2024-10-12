import 'package:flutter/material.dart';
import 'package:tennis_app/features/location/presentation/screens/details_screen.dart';

class CurrentLocationButton extends StatelessWidget {
  final String cityName; 

  const CurrentLocationButton(
      {super.key,
      required this.cityName}); 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
     
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailsScreen(cityName: cityName), 
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(90),
              topRight: Radius.circular(90),
            ),
          ),
        ),
        child: const Text(
          'Get Weather For Current Location',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 33, 60),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
