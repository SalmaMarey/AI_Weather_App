import 'dart:async';
import 'package:tennis_app/data/datasources/remote/models/on_boarding_data_model.dart';
import 'package:tennis_app/domain/on_boarding_repository.dart';


class OnBoardingRepositoryImpl implements OnBoardingRepository {
  @override
  Future<List<OnBoardingData>> fetchOnBoardingData() async {
    await Future.delayed(const Duration(seconds: 1)); 
    return [
      OnBoardingData(
        title: "Welcome to Your Tennis Tracker!",
        description: "Track your performance, every step of the way.",
         image: "assets/on_boarding_1.png", 
      ),
      OnBoardingData(
        title: "Monitor Your Activity: Steps, Distance, and Heart Rate.",
        description: "Stay on top of your progress with real-time tracking.",
        image: "assets/on_boarding_2.png",
      ),
      OnBoardingData(
        title: "Calories Burned & Goals Achieved.",
        description: "Keep fit and motivated, tracking calories burned with each workout.",
         image: "assets/on_boarding_3.png", 
      ),
    ];
  }
}