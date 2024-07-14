import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:multimodal_routeplanner/01_presentation/commons/mode_colors.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Waypoint.dart';

LatLngBounds fitTripBounds(Trip selectedTrip) {
  List<Waypoint> allWaypoints = selectedTrip.segments.expand((segment) => segment.waypoints).toList();

  double maxLat = allWaypoints.map((latLng) => latLng.lat).reduce(max);
  double maxLon = allWaypoints.map((latLng) => latLng.lon).reduce(max);
  double minLat = allWaypoints.map((latLng) => latLng.lat).reduce(min);
  double minLon = allWaypoints.map((latLng) => latLng.lon).reduce(min);
  LatLngBounds bounds = LatLngBounds(
    LatLng(maxLat, maxLon),
    LatLng(minLat, minLon),
  );

  return bounds;
}

mapSegmentModeToColor(String segmentType) {
  final ModeColors values = ModeColors();

  switch (segmentType) {
    case 'CAR':
      return values.carColor;

    case 'ECAR':
      return values.carColor;

    case 'MOPED':
      return values.mopedColor;

    case 'EMOPED':
      return values.mopedColor;

    case 'BICYCLE':
      return values.bikeColor;

    case 'EBICYCLE':
      return values.bikeColor;

    case 'TIER':
      return values.tierColor;

    case 'EMMY':
      return values.emmyColor;

    case 'FLINKSTER':
      return values.flinksterColor;

    case 'CAB':
      return values.cabColor;

    case 'SHARENOW':
      return values.sharenowColor;

    case 'WALK':
      return values.walkColor;

    case 'METRO':
      return values.metroColor;

    case 'REGIONAL_TRAIN':
      return values.trainColor;

    case 'TRAM':
      return values.tramColor;

    case 'BUS':
      return values.busColor;

    default:
      return values.carColor;
  }
}
