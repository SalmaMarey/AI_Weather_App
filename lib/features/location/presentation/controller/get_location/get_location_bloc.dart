import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:tennis_app/features/location/domain/get_location_repo.dart';
import 'package:tennis_app/features/weather/domain/weather_repository.dart';
import 'package:tennis_app/features/location/data/models/weather_data_model.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  final LocationRepository locationRepository;
  final WeatherRepository weatherRepository;

  GetLocationBloc(this.locationRepository, this.weatherRepository) : super(GetLocationInitial()) {
    on<FetchLocationEvent>((event, emit) async {
      emit(GetLocationLoading());

      try {
        Position position = await locationRepository.getCurrentLocation();
        String cityName = await locationRepository.getCityFromPosition(position);
        print("City fetched: $cityName");

        
        WeatherData weatherData = await weatherRepository.getWeatherByCoordinates(position.latitude, position.longitude);

        
        emit(GetLocationLoaded(position, cityName, weatherData));
      } catch (e) {
        emit(GetLocationError(e.toString()));
      }
    });
  }
}
