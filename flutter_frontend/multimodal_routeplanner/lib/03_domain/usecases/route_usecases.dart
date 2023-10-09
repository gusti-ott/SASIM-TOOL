import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/enums/MobilityModeEnum.dart';
import 'package:multimodal_routeplanner/03_domain/repositories/route_repository.dart';
import 'package:multimodal_routeplanner/04_infrastructure/repositories/route_respoitory_impl.dart';
import 'package:multimodal_routeplanner/logger.dart';

class RoutePlannerUsecases {
  final RouteRepository routeRepository = RouteRepositoryImpl();

  Logger logger = getLogger();

  Future<Trip> getTrip(
      {required String startInput,
      required String endInput,
      required MobilityMode mode}) async {
    return routeRepository.getTripFromApi(
        startInput: startInput, endInput: endInput, mode: mode);
  }

  Map<String, Trip> getListAddedTrips(
      {required Map<String, Trip> trips, required Trip trip}) {
    Map<String, Trip> newTrips = trips;
    newTrips[trip.mode] = trip;

    List<Trip> sortedTrips = [];
    newTrips.values.toList().forEach((element) => sortedTrips.add(element));
    sortedTrips.sort(((a, b) =>
        a.costs.externalCosts.all.compareTo(b.costs.externalCosts.all)));

    Map<String, Trip> mapSortedTrips = {};
    for (var element in sortedTrips) {
      mapSortedTrips[element.mode] = element;
    }
    return mapSortedTrips;
  }

  Map<String, Trip> getListRemovedTrips(
      {required Map<String, Trip> trips, required String mode}) {
    trips.remove(mode);

    List<Trip> sortedTrips = [];
    trips.values.toList().forEach((element) => sortedTrips.add(element));
    sortedTrips.sort(((a, b) =>
        a.costs.externalCosts.all.compareTo(b.costs.externalCosts.all)));

    Map<String, Trip> mapSortedTrips = {};
    for (var element in sortedTrips) {
      mapSortedTrips[element.mode] = element;
    }
    return mapSortedTrips;
  }

  Future<List<Trip>> getAllTrips(
      {required String startInput, required String endInput}) async {
    List<Trip> listTrips = [];

    // get car trip
    try {
      Trip carTrip = await routeRepository.getTripFromApi(
          startInput: startInput,
          endInput: endInput,
          mode: MobilityMode(mode: MobilityModeEnum.car));
      listTrips.add(carTrip);
    } catch (e) {
      logger.e(e.toString());
    }

    // get bike trip
    try {
      Trip bikeTrip = await routeRepository.getTripFromApi(
          startInput: startInput,
          endInput: endInput,
          mode: MobilityMode(mode: MobilityModeEnum.bike));
      listTrips.add(bikeTrip);
    } catch (e) {
      logger.e(e.toString());
    }

    // get walk trip
    try {
      Trip walkTrip = await routeRepository.getTripFromApi(
          startInput: startInput,
          endInput: endInput,
          mode: MobilityMode(mode: MobilityModeEnum.walk));
      listTrips.add(walkTrip);
    } catch (e) {
      logger.e(e.toString());
    }

    // get pt trip
    try {
      Trip ptTrip = await routeRepository.getTripFromApi(
          startInput: startInput,
          endInput: endInput,
          mode: MobilityMode(mode: MobilityModeEnum.mvg));
      listTrips.add(ptTrip);
    } catch (e) {
      logger.e(e.toString());
    }

    // get intermodal trip
    try {
      Trip intermodalTrip = await routeRepository.getTripFromApi(
          startInput: startInput,
          endInput: endInput,
          mode: MobilityMode(mode: MobilityModeEnum.intermodal));
      listTrips.add(intermodalTrip);
    } catch (e) {
      logger.e(e.toString());
    }

    return listTrips;
  }
}
