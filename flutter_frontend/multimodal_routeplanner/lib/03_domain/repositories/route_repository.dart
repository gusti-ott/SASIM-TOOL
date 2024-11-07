import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

abstract class RouteRepository {
  Future<Trip> getTripFromApi(
      {required String startInput,
      required String endInput,
      String? startCoordinates,
      String? endCoordinates,
      required MobilityMode mode,
      bool? quickResponse});
}
