import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';

import 'package:tennis_app/features/on_boarding/presentation/controllers/on_boarding_bloc/on_boarding_bloc.dart';
import 'package:tennis_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:tennis_app/features/weather/data/weather_repository_impl.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/location/data/get_location_repo_impl.dart';
import 'features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'features/weather/presentation/controllers/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authenticationRepository: AuthenticationRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => GetLocationBloc(LocationRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(WeatherRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const OnBoardingScreen(),
      ),
    );
  }
}
