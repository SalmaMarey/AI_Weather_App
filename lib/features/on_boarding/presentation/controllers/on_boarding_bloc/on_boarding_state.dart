// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tennis_app/features/on_boarding/data/models/on_boarding_data_model.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {
  final int pageIndex;
  OnBoardingInitial(this.pageIndex);
}

class LoadingOnBoardingData extends OnBoardingState {}

class OnBoardingDataLoaded extends OnBoardingState {
  final List<OnBoardingData> data;
  OnBoardingDataLoaded(this.data);
}

class OnBoardingDataError extends OnBoardingState {
  final String message;
  OnBoardingDataError(this.message);
}
