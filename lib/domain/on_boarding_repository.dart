import 'package:tennis_app/data/datasources/remote/models/on_boarding_data_model.dart';


abstract class OnBoardingRepository {
  Future<List<OnBoardingData>> fetchOnBoardingData();
}