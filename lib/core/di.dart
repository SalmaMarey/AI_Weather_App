import 'package:get_it/get_it.dart';
import 'package:tennis_app/features/auth/data/auth_repository_impl.dart';
import 'package:tennis_app/features/auth/domain/auth_repository.dart';
import 'package:tennis_app/features/location/data/location_weather_repo_impl.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';
import 'package:tennis_app/features/weather/data/weather_repository_impl.dart';
import 'package:tennis_app/features/weather/domain/weather_repository.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<LocationWeatherRepository>(
      () => LocationWeatherRepositoryImpl());

  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());

  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl());
}
