import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
