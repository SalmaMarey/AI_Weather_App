// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';


@immutable
abstract class OnBoardingEvent {}

class OnBoardingPageChanged extends OnBoardingEvent {
  final int pageIndex;
  OnBoardingPageChanged(this.pageIndex);
}

class FetchOnBoardingData extends OnBoardingEvent {}