part of 'get_location_bloc.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}
class GetLocationLoaded extends GetLocationState {
  final Position position;
  final String cityName;
  final WeatherData weatherData; 

  GetLocationLoaded(this.position, this.cityName, this.weatherData);
}

class GetLocationError extends GetLocationState {
  final String message;

  GetLocationError(this.message);
}
