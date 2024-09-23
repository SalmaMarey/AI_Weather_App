import 'package:bloc/bloc.dart';
import 'package:tennis_app/domain/on_boarding_repository.dart';
import 'on_boarding_event.dart';
import 'on_boarding_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final OnBoardingRepository repository;

  OnBoardingBloc(this.repository) : super(OnBoardingInitial(0)) {
    on<OnBoardingPageChanged>((event, emit) {
      emit(OnBoardingInitial(event.pageIndex));
    });

    on<FetchOnBoardingData>((event, emit) async {
      emit(LoadingOnBoardingData());
      try {
        final data = await repository.fetchOnBoardingData();
        emit(OnBoardingDataLoaded(data));
      } catch (e) {
        emit(OnBoardingDataError(e.toString()));
      }
    });
  }
}
