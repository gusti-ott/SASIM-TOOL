import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/route_usecases.dart';
import 'package:multimodal_routeplanner/logger.dart';

part 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsCubit() : super(TripsInitial());

  final RoutePlannerUsecases _routePlannerUsecases = RoutePlannerUsecases();
  final Logger logger = getLogger();
  List<Trip> chachedListTrips = [];
  String cachedStartInput = '';
  String cachedEndInput = '';

  Future<void> loadTrips(String startInput, String endInput) async {
    if (cachedStartInput != startInput || cachedEndInput != endInput) {
      emit(TripsLoading());
      cachedStartInput = startInput;
      cachedEndInput = endInput;
      try {
        List<Trip> listTrips =
            await _routePlannerUsecases.getAllTrips(startInput: startInput, endInput: endInput);
        emit(TripsLoaded(listTrips));
      } catch (e) {
        logger.e(e.toString());
        emit(TripsError(e.toString()));
      }
    }
  }
}
