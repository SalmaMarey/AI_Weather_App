import 'package:get_it/get_it.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source_impl.dart';
import 'package:tennis_app/features/location/data/location_weather_repo_impl.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';
import 'package:tennis_app/features/location/domain/use_case/get_city_name_from_coordinates.dart';
import 'package:tennis_app/features/location/domain/use_case/get_current_location.dart';
import 'package:tennis_app/features/location/domain/use_case/get_forecast.dart';
import 'package:tennis_app/features/location/domain/use_case/get_weather.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<LocationWeatherDataSource>(
    () => LocationWeatherDataSourceImpl(),
  );
  getIt.registerLazySingleton<LocationWeatherRepository>(
    () => LocationWeatherRepositoryImpl(
      getIt<LocationWeatherDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
      () => GetCurrentLocation(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetCityNameFromCoordinates(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetWeather(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetForecast(getIt<LocationWeatherRepository>()));
}
