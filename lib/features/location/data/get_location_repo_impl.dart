import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:tennis_app/features/location/domain/get_location_repo.dart';

class LocationRepositoryImpl implements LocationRepository {
  final String apiKey = 'e50b199406a3442d8dd232306243009';

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Future<String> getCityFromPosition(Position position) async {
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first.locality ?? 'Unknown';
  }
}
