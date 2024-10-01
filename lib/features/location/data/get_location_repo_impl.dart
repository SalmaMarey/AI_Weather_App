import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/features/location/domain/get_location_repo.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
