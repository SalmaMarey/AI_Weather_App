// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tennis_app/core/di.dart';
import 'package:tennis_app/features/location/domain/use_case/get_current_location.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fetchLocationAndNavigate();
  }

  Future<void> _fetchLocationAndNavigate() async {
    final position = await getIt<GetCurrentLocation>().call();
    Navigator.pushReplacementNamed(
      context,
      '/locationweather',
      arguments: {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
