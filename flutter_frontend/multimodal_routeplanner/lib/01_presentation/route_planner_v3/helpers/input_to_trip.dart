import 'package:collection/collection.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/logger.dart';

Logger logger = getLogger();

String? getTripModeFromInput(
    {required SelectionMode? mode, required bool? isElectric, required bool? isShared, required List<Trip>? trips}) {
  if (mode == null || isElectric == null || isShared == null) {
    logger.e('getTripModeFromInput: mode, isElectric or isShared is null');
    return null;
  }

  // return for public transport
  if (mode == SelectionMode.publicTransport) {
    return 'PT';
  }

  // return car
  else if (mode == SelectionMode.car) {
    if (isShared) {
      if (trips?.firstWhereOrNull((element) => element.mode == 'SHARENOW') == null &&
          trips?.firstWhereOrNull((element) => element.mode == 'FLINKSTER') != null) {
        return 'FLINKSTER';
      } else {
        return 'SHARENOW';
      }
    } else {
      if (isElectric) {
        return 'ECAR';
      } else {
        return 'CAR';
      }
    }
  }

  // return for bicycle
  else if (mode == SelectionMode.bicycle) {
    if (isShared) {
      if (trips?.firstWhereOrNull((element) => element.mode == 'CAB') == null &&
          trips?.firstWhereOrNull((element) => element.mode == 'MVG_BIKE') != null) {
        return 'MVG_BIKE';
      } else {
        return 'CAB';
      }
    } else {
      if (isElectric) {
        return 'EBICYCLE';
      } else {
        return 'BICYCLE';
      }
    }
  } else {
    return null;
  }
}

bool? getIsElectricFromTripMode(String mode) {
  if (mode == 'EBICYCLE' || mode == 'ECAR') {
    return true;
  } else if (mode == 'CAB' || mode == 'SHARENOW' || mode == 'CAR' || mode == 'BICYCLE') {
    return false;
  }
  return null;
}

bool? getIsSharedFromTripMode(String mode) {
  if (mode == 'SHARENOW' || mode == 'CAB') {
    return true;
  } else if (mode == 'EBICYCLE' || mode == 'ECAR' || mode == 'CAR' || mode == 'BICYCLE') {
    return false;
  }
  return null;
}

SelectionMode getSelectionModeFromTripMode(String mode) {
  if (mode == 'PT') {
    return SelectionMode.publicTransport;
  } else if (mode == 'BICYCLE' || mode == 'EBICYCLE' || mode == 'CAB') {
    return SelectionMode.bicycle;
  } else if (mode == 'SHARENOW' || mode == 'ECAR' || mode == 'CAR') {
    return SelectionMode.car;
  }
  return SelectionMode.bicycle;
}

String getBicycleTripMode({required bool isElectric, required bool isShared, required List<Trip> trips}) {
  if (isShared) {
    if (trips.firstWhereOrNull((element) => element.mode == 'CAB') == null &&
        trips.firstWhereOrNull((element) => element.mode == 'MVG_BIKE') != null) {
      return 'MVG_BIKE';
    } else {
      return 'CAB';
    }
  } else {
    if (isElectric) {
      return 'EBICYCLE';
    } else {
      return 'BICYCLE';
    }
  }
}

String getCarTripMode({required bool isElectric, required bool isShared, required List<Trip> trips}) {
  if (isShared) {
    if (trips.firstWhereOrNull((element) => element.mode == 'SHARENOW') == null &&
        trips.firstWhereOrNull((element) => element.mode == 'FLINKSTER') != null) {
      return 'FLINKSTER';
    } else {
      return 'SHARENOW';
    }
  } else {
    if (isElectric) {
      return 'ECAR';
    } else {
      return 'CAR';
    }
  }
}

String getPublicTransportTripMode() {
  return 'PT';
}
