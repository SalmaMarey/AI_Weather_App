import 'package:bloc/bloc.dart';

import 'package:tennis_app/presentation/controllers/on_boarding_bloc/on_boarding_event.dart';
import 'package:tennis_app/presentation/controllers/on_boarding_bloc/on_boarding_state.dart';
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
        image:
            "https://img.freepik.com/free-photo/tennis-player_1368-3038.jpg?t=st=1727205964~exp=1727209564~hmac=32e34db867778820a277e2250dcda4df4794c708c30482bc2d423b1b042eaa70&w=2000",
      ),
      OnBoardingData(
        title: "Monitor Your Activity: Steps, Distance, and Heart Rate.",
        description: "Stay on top of your progress with real-time tracking.",
        image:
            "https://img.freepik.com/free-photo/tennis-player_1368-3037.jpg?t=st=1727205910~exp=1727209510~hmac=a251e78d1035abc7d650c1df96d571c50b93bf4f4cdd4b17fa6865513383e884&w=2000",
      ),
      OnBoardingData(
        title: "Calories Burned & Goals Achieved.",
        description:
            "Keep fit and motivated, tracking calories burned with each workout.",
        image:
            "https://img.freepik.com/free-photo/young-training-people-tennis-length_1368-1933.jpg?t=st=1727201703~exp=1727205303~hmac=17b766098fe96beb56f16eb80a3db1035b1655b1cd2d6a7d3c660a9aa5926c63&w=2000",
      ),
    ];
  }
}
