import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:tennis_app/features/location/domain/get_location_repo.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  final LocationRepository locationRepository;

  GetLocationBloc(this.locationRepository) : super(GetLocationInitial()) {
    on<FetchLocationEvent>((event, emit) async {
      emit(GetLocationLoading());

      try {
        Position position = await locationRepository.getCurrentLocation();
        emit(GetLocationLoaded(position));
      } catch (e) {
        emit(GetLocationError(e.toString()));
      }
    });
  }
}
