import 'package:bloc/bloc.dart';
import 'package:tennis_app/presentation/controllers/bloc/on_boarding_event.dart';
import 'package:tennis_app/presentation/controllers/bloc/on_boarding_state.dart';
import 'package:tennis_app/data/datasources/remote/models/on_boarding_data_model.dart'; 


class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingInitial(0)) {
    on<OnBoardingPageChanged>((event, emit) {
      emit(OnBoardingInitial(event.pageIndex));
    });

    on<FetchOnBoardingData>((event, emit) async {
      emit(LoadingOnBoardingData());
      try {
        final data = await _fetchOnBoardingData();
        emit(OnBoardingDataLoaded(data));
      } catch (e) {
        emit(OnBoardingDataError(e.toString()));
      }
    });
  }

  Future<List<OnBoardingData>> _fetchOnBoardingData() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      OnBoardingData(
        title: "Welcome to Your Tennis Tracker!",
        description: "Track your performance, every step of the way.",
        image: "https://i.imgur.com/icIvxX9.png",
      ),
      OnBoardingData(
        title: "Monitor Your Activity: Steps, Distance, and Heart Rate.",
        description: "Stay on top of your progress with real-time tracking.",
        image: "https://i.imgur.com/x5xUX17.png",
      ),
      OnBoardingData(
        title: "Calories Burned & Goals Achieved.",
        description: "Keep fit and motivated, tracking calories burned with each workout.",
        image: "https://i.imgur.com/X8O2PFw.png",
      ),
    ];
  }
}