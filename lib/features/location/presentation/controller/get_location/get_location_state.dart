part of 'get_location_bloc.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}

class GetLocationLoaded extends GetLocationState {
  final Position position;

  GetLocationLoaded(this.position);
}

class GetLocationError extends GetLocationState {
  final String message;

  GetLocationError(this.message);
}
