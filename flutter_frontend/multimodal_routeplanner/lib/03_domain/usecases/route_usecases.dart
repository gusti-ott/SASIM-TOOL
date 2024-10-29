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
      {required String startInput, required String endInput, required MobilityMode mode, bool? quickResponse}) async {
    return routeRepository.getTripFromApi(
        startInput: startInput, endInput: endInput, mode: mode, quickResponse: quickResponse);
  }

  Map<String, Trip> getListAddedTrips({required Map<String, Trip> trips, required Trip trip}) {
    Map<String, Trip> newTrips = trips;
    newTrips[trip.mode] = trip;

    List<Trip> sortedTrips = [];
    newTrips.values.toList().forEach((element) => sortedTrips.add(element));
    sortedTrips.sort(((a, b) => a.costs.externalCosts.all.compareTo(b.costs.externalCosts.all)));

    Map<String, Trip> mapSortedTrips = {};
    for (var element in sortedTrips) {
      mapSortedTrips[element.mode] = element;
    }
    return mapSortedTrips;
  }

  Map<String, Trip> getListRemovedTrips({required Map<String, Trip> trips, required String mode}) {
    trips.remove(mode);

    List<Trip> sortedTrips = [];
    trips.values.toList().forEach((element) => sortedTrips.add(element));
    sortedTrips.sort(((a, b) => a.costs.externalCosts.all.compareTo(b.costs.externalCosts.all)));

    Map<String, Trip> mapSortedTrips = {};
    for (var element in sortedTrips) {
      mapSortedTrips[element.mode] = element;
    }
    return mapSortedTrips;
  }

  Future<List<Trip>> getAllTrips({required String startInput, required String endInput}) async {
    List<Trip> listTrips = [];

    // get car trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.car));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch CAR trip: ${e.toString()}');
    }

    // get e-car trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.ecar));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch E-CAR trip: ${e.toString()}');
    }

    // get bike trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.bike));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch BIKE trip: ${e.toString()}');
    }

    // get e-bike trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.ebike));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch E-BIKE trip: ${e.toString()}');
    }

    // get moped trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.moped));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch Moped trip: ${e.toString()}');
    }

    // get e-moped trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.emoped));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch E-Moped trip: ${e.toString()}');
    }

    // get emmy trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.emmy));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch Emmy trip: ${e.toString()}');
    }

    // get tier trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.tier));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch TIER trip: ${e.toString()}');
    }

    // get sharenow trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.sharenow));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch Sharenow trip: ${e.toString()}');
    }

    // get walk trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.walk));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch WALK trip: ${e.toString()}');
    }

    // get pt trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.mvg));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch PT trip: ${e.toString()}');
    }

    // get intermodal trip
    try {
      Trip trip = await routeRepository.getTripFromApi(
          startInput: startInput, endInput: endInput, mode: MobilityMode(mode: MobilityModeEnum.intermodal));
      listTrips.add(trip);
    } catch (e) {
      logger.e('could not fetch INTERMODAL trip: ${e.toString()}');
    }

    return listTrips;
  }

  Future<List<Trip>> getV3Trips({required String startInput, required String endInput}) async {
    List<Trip> listTrips = [];

    //function to try to add a trip to the list of trips
    void tryAddTrip(MobilityModeEnum mode) async {
      try {
        Trip trip = await routeRepository.getTripFromApi(
            startInput: startInput, endInput: endInput, mode: MobilityMode(mode: mode));
        listTrips.add(trip);
        logger.i('fetched $mode trip');
      } catch (e) {
        logger.e('could not fetch $mode trip: ${e.toString()}');
      }
    }

    // get bike trip
    tryAddTrip(MobilityModeEnum.bike);

    // get e-bike trip
    tryAddTrip(MobilityModeEnum.ebike);

    // get cab trip
    tryAddTrip(MobilityModeEnum.cab);

    //check whether trips contains a trip with mode "CAB"
    if (!listTrips.contains((element) => element.mode == "CAB")) {
      //get mvg bike trip
      tryAddTrip(MobilityModeEnum.mvgBike);
    }

    // get car trip
    tryAddTrip(MobilityModeEnum.car);

    // get ecar trip
    tryAddTrip(MobilityModeEnum.ecar);

    // get sharenow trip
    tryAddTrip(MobilityModeEnum.sharenow);

    if (!listTrips.contains((element) => element.mode == "SHARENOW")) {
      // get tier trip
      tryAddTrip(MobilityModeEnum.flinkster);
    }

    // get mvg trip
    tryAddTrip(MobilityModeEnum.mvg);

    return listTrips;
  }
}
