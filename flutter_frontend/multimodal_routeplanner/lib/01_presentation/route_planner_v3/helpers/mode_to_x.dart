import 'package:flutter/material.dart';

IconData getIconDataFromMode(String mode) {
  switch (mode) {
    case 'WALK':
      return Icons.directions_walk_outlined;
    case 'CAR':
    case 'SHARENOW':
      return Icons.directions_car_outlined;
    case 'ECAR':
      return Icons.electric_car_outlined;
    case 'CAB':
    case 'BICYCLE':
      return Icons.pedal_bike_outlined;
    case 'EBICYCLE':
      return Icons.electric_bike_outlined;
    case 'PT':
      return Icons.directions_bus_outlined;
    default:
      return Icons.directions_walk;
  }
}
