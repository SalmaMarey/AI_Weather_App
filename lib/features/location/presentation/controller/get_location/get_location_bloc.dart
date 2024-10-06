import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationWeatherRepository locationWeatherRepository;

  LocationBloc({required this.locationWeatherRepository})
      : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final position = await locationWeatherRepository.getCurrentLocation();
        final city = await locationWeatherRepository.getCityNameFromCoordinates(
            position.latitude, position.longitude);

        final weatherData = await locationWeatherRepository.getWeather(city);
        final forecastData = await locationWeatherRepository.getForecast(city);

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
