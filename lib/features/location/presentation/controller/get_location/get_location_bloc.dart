import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:tennis_app/features/location/domain/get_location_repo.dart';
import 'package:tennis_app/features/location/domain/weather_location_repo.dart';
import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  final WeatherRepository weatherRepository;

  LocationBloc(
      {required this.locationRepository, required this.weatherRepository})
      : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final position = await locationRepository.getCurrentLocation();
        final city = await locationRepository.getCityNameFromCoordinates(
            position.latitude, position.longitude);

        final weatherData = await weatherRepository.getWeather(city);
        final forecastData = await weatherRepository.getForecast(city);

        List<DailyForecast> forecastList =
            (forecastData['forecast']['forecastday'] as List)
                .map((day) => DailyForecast(
                      date: day['date'],
                      temperature: day['day']['avgtemp_c'],
                      weatherCondition: day['day']['condition']['text'],
                      imagePath: day['day']['condition']['icon'],
                    ))
                .toList();

        emit(LocationLoaded(
            position: position,
            weatherData: weatherData,
            forecast: forecastList));
      } catch (e) {
        // emit(LocationError(message: e.toString()));
      }
    });
  }
}
