import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tennis_app/presentation/controllers/on_boarding_bloc/on_boarding_bloc.dart';
import 'package:tennis_app/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:tennis_app/presentation/screens/on_boarding_screen.dart';
import 'data/auth_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase initialization

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
    // final AuthenticationRepository authenticationRepository =
    //     AuthenticationRepositoryImpl();

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
